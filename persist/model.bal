import ballerina/time;
import ballerina/persist as _;

type Patient record {|
    readonly int id;
    string name;
    int age;
    string address;
    string phoneNumber;
    Gender gender;
	Appointment[] appointment;
|};

enum Gender {
    MALE,
    FEMALE
}

type Doctor record {|
    readonly int id;
    string name;
    string specialty;
    string phoneNumber;
	Appointment[] appointment;
|};

type Appointment record {|
    readonly int id;
    Patient patient;
    Doctor doctor;
    string reason;
    time:Civil appointmentTime;
    AppointmentStatus status;
|};

enum AppointmentStatus {
    SCHEDULED,
    STARTED,
    ENDED
}
