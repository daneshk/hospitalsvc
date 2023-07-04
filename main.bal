import hospitalsvc.db;
import ballerina/http;
import ballerina/time;
import ballerina/persist;

type NewAppointment record {|
    int id;
    time:Civil time;
    int patientId;
    int doctorId;
    string reason;
|};

type DoctorWithSpecialty record {|
    int id;
    string name;
    string specialty;
|};

type AppointmentWithPatient record {|
    int id;
    db:AppointmentStatus status;
    string reason;
    record {|
        string name;
        int age;
        string phoneNumber;
    |} patient;
    int doctorId;
    time:Civil appointmentTime;
|};

isolated service /hospital on new http:Listener(9090) {
    private final db:Client dbClient;

    public function init() returns error? {
        self.dbClient = check new ();
    }

    resource function post doctors(db:DoctorInsert doctor) returns int|http:InternalServerError|http:Conflict {
        int[]|persist:Error response = self.dbClient->/doctors.post([doctor]);
        if (response is persist:Error) {
            if (response is persist:AlreadyExistsError) {
                return http:CONFLICT;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
        return response[0];
    }

    resource function post patients(db:PatientInsert patient) returns int|http:InternalServerError|http:Conflict {
        int[]|persist:Error response = self.dbClient->/patients.post([patient]);
        if (response is persist:Error) {
            if (response is persist:AlreadyExistsError) {
                return http:CONFLICT;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
        return response[0];
    }

    resource isolated function post appointment(NewAppointment appointment) returns int|http:InternalServerError|http:Conflict {
        db:AppointmentInsert appointmentInsert = {
            id: appointment.id,
            appointmentTime: appointment.time,
            patientId: appointment.patientId,
            doctorId: appointment.doctorId,
            reason: appointment.reason,
            status: "SCHEDULED"
        };
        int[]|persist:Error response = self.dbClient->/appointments.post([appointmentInsert]);
        if (response is persist:Error) {
            if (response is persist:AlreadyExistsError) {
                return http:CONFLICT;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
        return response[0];
    }

    resource function get doctors() returns DoctorWithSpecialty[]|error {
        stream<DoctorWithSpecialty, persist:Error?> doctors = self.dbClient->/doctors.get();
        return from DoctorWithSpecialty doctor in doctors
            select doctor;
    }

    resource function get patients/[int id]() returns db:Patient|http:InternalServerError|http:NotFound {
        db:Patient|persist:Error patient = self.dbClient->/patients/[id];

        if patient is persist:Error {
            if patient is persist:NotFoundError {
                return http:NOT_FOUND;
            }
            return http:INTERNAL_SERVER_ERROR;
        }

        return patient;
    }

    resource function get doctors/[int id]/appointments(int year, int month, int day) returns AppointmentWithPatient[]|http:InternalServerError|http:BadRequest { 
        stream<AppointmentWithPatient, persist:Error?> appointments = self.dbClient->/appointments.get();
        AppointmentWithPatient[]|persist:Error result = from AppointmentWithPatient appointment in appointments
            where appointment.doctorId == id
            && appointment.appointmentTime.year == year
            && appointment.appointmentTime.month == month
            && appointment.appointmentTime.day == day
            select appointment;
        if (result is persist:Error) {
            return http:INTERNAL_SERVER_ERROR;
        }

        return result;
    }

    resource function patch appointments/[int id](@http:Payload db:AppointmentStatus status) returns http:NoContent|http:NotFound|http:InternalServerError {
        db:Appointment|persist:Error result = self.dbClient->/appointments/[id].put({status});
        if (result is persist:Error) {
            if (result is persist:NotFoundError) {
                return http:NOT_FOUND;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:NO_CONTENT;
    }

    resource function delete appointments/[int id]() returns http:NoContent|http:NotFound|http:InternalServerError {
        db:Appointment|persist:Error result = self.dbClient->/appointments/[id].delete();
        if (result is persist:Error) {
            if (result is persist:NotFoundError) {
                return http:NOT_FOUND;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:NO_CONTENT;
    }

    resource function delete patients/[int id]/appointments(int year, int month, int day) returns http:NoContent|http:NotFound|http:InternalServerError|http:BadRequest {

        stream<db:Appointment, persist:Error?> appointments = self.dbClient->/appointments.get();
        db:Appointment[]|persist:Error result = from db:Appointment appointment in appointments
            where appointment.patientId == id
            && appointment.appointmentTime.year == year
            && appointment.appointmentTime.month == month
            && appointment.appointmentTime.day == day
            select appointment;
        if (result is persist:Error) {
            if (result is persist:NotFoundError) {
                return http:NOT_FOUND;
            }
            return http:INTERNAL_SERVER_ERROR;
        }

        foreach db:Appointment appointment in result {
            db:Appointment|persist:Error unionResult = self.dbClient->/appointments/[appointment.id].delete();
            if unionResult is persist:Error {
                return http:INTERNAL_SERVER_ERROR;
            }
        }

        return http:NO_CONTENT;
    }

}

