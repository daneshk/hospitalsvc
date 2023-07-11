-- Description: This file contains the data seeds for the database

-- Add Doctor data to the database for demonstration purposes
INSERT INTO `Doctor`(id, name, phoneNumber, specialty) VALUES (1, 'Dr. John Doe', '+94771234567', 'Cardiology');
INSERT INTO `Doctor`(id, name, phoneNumber, specialty) VALUES (2, 'Dr. Jane Doe', '+94771234568', 'Neurology');
INSERT INTO `Doctor`(id, name, phoneNumber, specialty) VALUES (3, 'Dr. Max Good', '+94771234569', 'Pediatrics');
INSERT INTO `Doctor`(id, name, phoneNumber, specialty) VALUES (4, 'Dr. Sam Smith', '+94771234570', 'ENT Surgeon');
INSERT INTO `Doctor`(id, name, phoneNumber, specialty) VALUES (5, 'Dr. Ann Smith', '+94771234571', 'Physitian');

-- Add Patient data to the database for demonstration purposes
INSERT INTO `Patient`(id, name, phoneNumber, age, address, gender) VALUES (1, 'Anita Bath', '+94712223890', 34, 'No 20, Palm Grove, Colombo 03', 'MALE');
INSERT INTO `Patient`(id, name, phoneNumber, age, address, gender) VALUES (2, 'Emma Smith', '+94712223891', 25, 'No 117, Stuart Road, Colombo 07,', 'FEMALE');
INSERT INTO `Patient`(id, name, phoneNumber, age, address, gender) VALUES (3, 'Dee End', '+94762239480', 70, 'No 121, Main Street, Galle', 'MALE');
INSERT INTO `Patient`(id, name, phoneNumber, age, address, gender) VALUES (4, 'Sarah Moanees', '+94772394123', 55, 'No 92 Church Street, Colombo', 'FEMALE');
INSERT INTO `Patient`(id, name, phoneNumber, age, address, gender) VALUES (5, 'Saman Kumara', '+94772802233', 40, 'No 345, High level Road, Maharagama', 'MALE');

-- Add Appointment data to the database for demonstration purposes
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (1, 1, 1, '2021-05-01 10:00:00', 'ENDED', 'Heart pain');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (2, 2, 2, '2021-05-01 11:00:00', 'ENDED', 'Headache');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (3, 3, 3, '2021-07-02 12:00:00', 'SCHEDULED', 'Fever');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (4, 4, 4, '2021-05-01 13:00:00', 'ENDED', 'Ear pain');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (5, 5, 5, '2021-05-01 14:00:00', 'SCHEDULED', 'Stomach pain');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (6, 2, 1, '2021-07-01 15:00:00', 'STARTED', 'Heart pain');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (7, 3, 2, '2021-05-01 16:00:00', 'ENDED', 'Headache');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (8, 4, 1, '2021-07-01 17:00:00', 'SCHEDULED', 'Fever');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (9, 5, 2, '2021-05-01 18:00:00', 'ENDED', 'Ear pain');
INSERT INTO `Appointment`(id, patientId, doctorId, appointmentTime, status, reason) VALUES (10, 1, 3, '2021-07-01 19:00:00', 'STARTED', 'Stomach pain');
