import ballerina/time;
import ballerina/persist as _;

type Patient record {|
    readonly int id;
    string name;
    string phoneNumber;
    int age;
    string address;
    Gender gender;
	Appointment[] appointment;
	// ClinicalData[] clinicaldata;
|};

enum Gender {
    MALE,
    FEMALE
}

// enum MedicalRecordType {
//     BLOOD_PRESSURE,
//     BLOOD_SUGAR,
//     CHOLESTEROL,
//     HEART_RATE,
//     TEMPERATURE
// };

// type ClinicalData record {|
//     readonly int id;
//     Patient patient;
//     MedicalRecordType recordType;
//     float value;
//     time:Civil recordTime;
//     Doctor doctor;
// |};

type Doctor record {|
    readonly int id;
    string name;
    string phoneNumber;
    string specialty;
	Appointment[] appointment;
	// ClinicalData[] clinicaldata;
|};

type Appointment record {|
    readonly int id;
    time:Civil appointmentTime;
    AppointmentStatus status;
    string reason;
    Patient patient;
    Doctor doctor;
|};

enum AppointmentStatus {
    SCHEDULED,
    STARTED,
    ENDED
}
