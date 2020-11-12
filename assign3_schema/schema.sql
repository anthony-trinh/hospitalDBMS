/*  CPS510 A3
    Anthony Trinh, 500831193 
    Amiel Castillo, 500883624
    Jose Manipon, 500906166
    Section 2, group 28 */

-- drop created entity and relation tables
DROP TABLE bills;
DROP TABLE added_to;
DROP TABLE has;
DROP TABLE creates;
DROP TABLE stored;
DROP TABLE has_access_to;
DROP TABLE saved_to;
DROP TABLE contains;
DROP TABLE generates;
DROP TABLE schedules;
DROP TABLE registers;
DROP TABLE manages;
DROP TABLE scheduled_for;   
DROP TABLE administers;
DROP TABLE medical_history ;
DROP TABLE prescription;
DROP TABLE diagnosis;
DROP TABLE medicine;
DROP TABLE invoice;
DROP TABLE appointment ; 
DROP TABLE patient ; 
DROP TABLE nurse ;
DROP TABLE doctor;
DROP TABLE employee;
DROP TABLE hospital;

-- create entity tables
CREATE TABLE hospital (
    hospital_name VARCHAR2(32) NOT NULL,
    address_street VARCHAR2(32) NOT NULL,
    address_street2 VARCHAR2(32),
    address_city VARCHAR2(32) NOT NULL,
    address_province VARCHAR2(2) NOT NULL,
    address_postalcode VARCHAR2(6) NOT NULL,
    address_country VARCHAR2(3) DEFAULT 'CAD',
    phone VARCHAR2(16) NOT NULL, 
    PRIMARY KEY(hospital_name)
);

CREATE TABLE employee (
    employee_id INT NOT NULL,
    f_name VARCHAR2(64) NOT NULL, 
    l_name VARCHAR2(64) NOT NULL, 
    date_of_birth DATE NOT NULL, 
    gender VARCHAR2(6) NOT NULL,
    age INT NOT NULL,
    address_street VARCHAR2(32) NOT NULL,
    address_street2 VARCHAR2(32),
    address_city VARCHAR2(32) NOT NULL,
    address_province VARCHAR2(2) NOT NULL,
    address_postalcode VARCHAR2(6) NOT NULL UNIQUE,
    address_country VARCHAR2(3) DEFAULT 'CAD',
    phone VARCHAR2(16) NOT NULL, 
    email VARCHAR2(256),
    hospital_name VARCHAR2(32) NOT NULL,
    PRIMARY KEY(employee_id),
    FOREIGN KEY(hospital_name) REFERENCES hospital(hospital_name)
);

CREATE TABLE doctor (
    doctor_id INT NOT NULL,
    doctorlicense_expiry DATE NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY(doctor_id),
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE nurse ( 
    nurse_id INT NOT NULL,
    nurselicense_expiry DATE NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY(nurse_id),
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE patient (
    healthcard_no INT NOT NULL,
    f_name VARCHAR2(64) NOT NULL, 
    l_name VARCHAR2(64) NOT NULL, 
    date_of_birth DATE NOT NULL, 
    gender VARCHAR2(6) NOT NULL,
    age INT NOT NULL,
    address_street VARCHAR2(32) NOT NULL,
    address_street2 VARCHAR2(32),
    address_city VARCHAR2(32) NOT NULL,
    address_province VARCHAR2(2) NOT NULL,
    address_postalcode VARCHAR2(6) NOT NULL,
    address_country VARCHAR2(3) DEFAULT 'CAD',
    phone VARCHAR2(16) NOT NULL, 
    email VARCHAR2(256),
    PRIMARY KEY(healthcard_no)
); 

CREATE TABLE appointment (
    appointment_id INT NOT NULL, 
    appointment_date DATE NOT NULL, 
    appointment_time VARCHAR2(64) NOT NULL,
    room_no INT NOT NULL,
    nurse_id INT NOT NULL,
    healthcard_no INT NOT NULL,
    doctor_id INT NOT NULL,
    hospital_name VARCHAR2(32) NOT NULL,
    PRIMARY KEY(appointment_id),
    FOREIGN KEY(nurse_id) REFERENCES nurse(nurse_id),
    FOREIGN KEY(healthcard_no) REFERENCES patient(healthcard_no),
    FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY(hospital_name) REFERENCES hospital(hospital_name)
);

CREATE TABLE invoice (
    invoice_no INT NOT NULL,
    iupac_name VARCHAR2(64) NOT NULL,
    date_issued DATE NOT NULL,
    amount_owed VARCHAR2(10) NOT NULL,
    appointment_id INT NOT NULL,
    PRIMARY KEY (invoice_no),
    FOREIGN KEY(appointment_id) REFERENCES appointment(appointment_id)
);

CREATE TABLE diagnosis ( 
    diagnosis_id INT NOT NULL,
    results VARCHAR2(256) NOT NULL,
    appointment_id INT NOT NULL,
    PRIMARY KEY(diagnosis_id),
    FOREIGN KEY(appointment_id) REFERENCES appointment(appointment_id)
);

CREATE TABLE medicine (
    iupac_name VARCHAR2(64) NOT NULL, 
    generic_name VARCHAR2(64) NOT NULL,
    inventory INT NOT NULL, 
    price FLOAT NOT NULL,
    quantity VARCHAR2(32) NOT NULL,
    expiration_date DATE NOT NULL,
    manufacturer VARCHAR2(32) NOT NULL,
    PRIMARY KEY(iupac_name)
); 

CREATE TABLE prescription ( 
    prescription_no INT NOT NULL, 
    date_issued DATE NOT NULL,
    appointment_id INT NOT NULL,
    iupac_name VARCHAR2(64) NOT NULL,
    diagnosis_id INT NOT NULL,
    PRIMARY KEY(prescription_no),
    FOREIGN KEY(appointment_id) REFERENCES appointment(appointment_id),
    FOREIGN KEY(diagnosis_id) REFERENCES diagnosis(diagnosis_id),
    FOREIGN KEY(iupac_name) REFERENCES medicine(iupac_name)
);

CREATE TABLE medical_history (
    healthcard_no INT NOT NULL,
    appointment_id INT NOT NULL,
    diagnosis_id INT NOT NULL,
    medical_desc VARCHAR2(256) NOT NULL,
    PRIMARY KEY(healthcard_no),
    FOREIGN KEY(appointment_id) REFERENCES appointment(appointment_id),
    FOREIGN KEY(diagnosis_id) REFERENCES diagnosis(diagnosis_id)
);

-- create entity relations
CREATE TABLE administers (
    hospital_name REFERENCES hospital(hospital_name),
    employee_id REFERENCES employee(employee_id),
    PRIMARY KEY(hospital_name, employee_id)
);

CREATE TABLE scheduled_for (
    doctor_id REFERENCES doctor(doctor_id),
    appointment_id REFERENCES appointment(appointment_id),
    PRIMARY KEY(doctor_id, appointment_id)
);

CREATE TABLE manages (
    nurse_id REFERENCES nurse(nurse_id),
    appointment_id REFERENCES appointment(appointment_id),
    PRIMARY KEY(nurse_id, appointment_id)
);

CREATE TABLE registers (
    healthcard_no REFERENCES patient(healthcard_no),
    hospital_name REFERENCES hospital(hospital_name),
    PRIMARY KEY(healthcard_no, hospital_name) 
);

CREATE TABLE schedules (
    healthcard_no REFERENCES patient(healthcard_no),
    appointment_id REFERENCES appointment(appointment_id),
    PRIMARY KEY(healthcard_no, appointment_id)
);

CREATE TABLE generates (
    appointment_id REFERENCES appointment(appointment_id), 
    diagnosis_id REFERENCES diagnosis(diagnosis_id),
    PRIMARY KEY(appointment_id, diagnosis_id)
);

CREATE TABLE contains (
    diagnosis_id REFERENCES diagnosis(diagnosis_id),
    prescription_no REFERENCES prescription(prescription_no), 
    PRIMARY KEY(diagnosis_id, prescription_no)
);

CREATE TABLE saved_to (
    healthcard_no REFERENCES medical_history(healthcard_no),
    diagnosis_id REFERENCES diagnosis(diagnosis_id),
    PRIMARY KEY(diagnosis_id, healthcard_no)
);

CREATE TABLE has_access_to (
    doctor_id REFERENCES doctor(doctor_id),
    healthcard_no REFERENCES medical_history(healthcard_no),
    PRIMARY KEY(doctor_id, healthcard_no)
);

CREATE TABLE stored (
    healthcard_no REFERENCES medical_history(healthcard_no),
    hospital_name REFERENCES hospital(hospital_name),
    PRIMARY KEY(healthcard_no, hospital_name)
);

CREATE TABLE creates (
    hospital_name REFERENCES hospital(hospital_name),
    invoice_no REFERENCES invoice(invoice_no),
    PRIMARY KEY(hospital_name, invoice_no)
);

CREATE TABLE has (
    hospital_name REFERENCES hospital(hospital_name),
    iupac_name REFERENCES medicine(iupac_name),
    PRIMARY KEY(hospital_name, iupac_name)
);

CREATE TABLE added_to (
    iupac_name REFERENCES medicine(iupac_name),
    invoice_no REFERENCES invoice(invoice_no),
    PRIMARY KEY(iupac_name, invoice_no)
);

CREATE TABLE bills (
    invoice_no REFERENCES invoice(invoice_no),
    healthcard_no REFERENCES patient(healthcard_no),
    PRIMARY KEY(invoice_no, healthcard_no)
);

