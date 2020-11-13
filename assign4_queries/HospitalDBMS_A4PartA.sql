/*  CPS510 A3
    Anthony Trinh, 500831193 
    Amiel Castillo, 500883624
    Jose Manipon, 500906166
    Section 2, group 28 */
--------------
--- TABLES ---
--------------
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
    hospital_id INT NOT NULL,
    hospital_name VARCHAR2(32) NOT NULL,
    address_street VARCHAR2(32) NOT NULL,
    address_street2 VARCHAR2(32),
    address_city VARCHAR2(32) NOT NULL,
    address_province VARCHAR2(2) NOT NULL,
    address_postalcode VARCHAR2(6) NOT NULL,
    address_country VARCHAR2(3) DEFAULT 'CAD',
    phone VARCHAR2(16) NOT NULL, 
    PRIMARY KEY(hospital_id)
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
    hospital_id INT NOT NULL,
    PRIMARY KEY(employee_id),
    FOREIGN KEY(hospital_id) REFERENCES hospital(hospital_id)
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
    hospital_id INT NOT NULL,
    PRIMARY KEY(appointment_id),
    FOREIGN KEY(nurse_id) REFERENCES nurse(nurse_id),
    FOREIGN KEY(healthcard_no) REFERENCES patient(healthcard_no),
    FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY(hospital_id) REFERENCES hospital(hospital_id)
);

CREATE TABLE invoice (
    invoice_no INT NOT NULL,
    medicine_id INT NOT NULL,
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
    medicine_id INT NOT NULL,
    iupac_name VARCHAR2(64) NOT NULL, 
    generic_name VARCHAR2(64) NOT NULL,
    inventory INT NOT NULL, 
    price FLOAT NOT NULL,
    expiration_date DATE NOT NULL,
    manufacturer VARCHAR2(32) NOT NULL,
    PRIMARY KEY(medicine_id)
); 

CREATE TABLE prescription ( 
    prescription_no INT NOT NULL,
    dosage FLOAT NOT NULL,
    date_issued DATE NOT NULL,
    appointment_id INT NOT NULL,
    medicine_id INT NOT NULL,
    diagnosis_id INT NOT NULL,
    PRIMARY KEY(prescription_no),
    FOREIGN KEY(appointment_id) REFERENCES appointment(appointment_id),
    FOREIGN KEY(diagnosis_id) REFERENCES diagnosis(diagnosis_id),
    FOREIGN KEY(medicine_id) REFERENCES medicine(medicine_id)
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
    hospital_id REFERENCES hospital(hospital_id),
    employee_id REFERENCES employee(employee_id),
    PRIMARY KEY(hospital_id, employee_id)
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
    hospital_id REFERENCES hospital(hospital_id),
    PRIMARY KEY(healthcard_no, hospital_id) 
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
    hospital_id REFERENCES hospital(hospital_id),
    PRIMARY KEY(healthcard_no, hospital_id)
);

CREATE TABLE creates (
    hospital_id REFERENCES hospital(hospital_id),
    invoice_no REFERENCES invoice(invoice_no),
    PRIMARY KEY(hospital_id, invoice_no)
);

CREATE TABLE has (
    hospital_id REFERENCES hospital(hospital_id),
    medicine_id REFERENCES medicine(medicine_id),
    PRIMARY KEY(hospital_id, medicine_id)
);

CREATE TABLE added_to (
    medicine_id REFERENCES medicine(medicine_id),
    invoice_no REFERENCES invoice(invoice_no),
    PRIMARY KEY(medicine_id, invoice_no)
);

CREATE TABLE bills (
    invoice_no REFERENCES invoice(invoice_no),
    healthcard_no REFERENCES patient(healthcard_no),
    PRIMARY KEY(invoice_no, healthcard_no)
);


--------------
---- DATA ----
--------------
-- deletion of data
DELETE FROM hospital;
DELETE FROM employee;
DELETE FROM doctor;
DELETE FROM nurse;
DELETE FROM patient;

-- insertion of data
-- hospitals
INSERT INTO hospital (hospital_id, hospital_name,address_street,address_city,address_province,address_postalcode,phone) 
    VALUES (123, 'Toronto General Hospital', '200 Elizabeth St', 'Toronto', 'ON', 'M5G2C4','4167895297');
INSERT INTO hospital (hospital_id, hospital_name,address_street,address_city,address_province,address_postalcode,phone) 
    VALUES (124, 'Michael Garron Hospital', '825 Coxwell Ave', 'East York', 'ON', 'M4C3E7','4167893127');
INSERT INTO hospital (hospital_id, hospital_name,address_street,address_city,address_province,address_postalcode,phone) 
    VALUES (125, 'Toronto Western Hospital', '399 Bathurst St', 'Toronto', 'ON', 'M5T2S8','4167898713');

-- employees
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323952, 'Andrew', 'Musak', to_date('07/12/1987','mm/dd/yy'), 'M', 33, '121 Collins Rd.', 'Toronto', 'ON', 'M1V1N3', '4168794561','dr.andrew.musak33@gmail.com', 123);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323678, 'Mindy', 'Ramirez', to_date('10/10/1990','mm/dd/yy'), 'F', 30, '126 Sisao St.', 'Toronto', 'ON', 'M1P4R2', '6475213125','mindy.ramirez@gmail.com', 124);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323679, 'John', 'Cooper', to_date('08/10/1989','mm/dd/yy'), 'M', 27, 'B9 Prospect Street', 'Toronto', 'ON', 'M1PX13', '6475213256','cooper.john@gmail.com', 124);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323680, 'Michelle', 'Stanley', to_date('10/06/1991','mm/dd/yy'), 'F', 30, '202 Enble Street', 'Toronto', 'ON', 'M1D13C', '6473125676','stanley.michelle@gmail.com', 123);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323681, 'Sameul', 'Honey', to_date('10/12/1990','mm/dd/yy'), 'M', 31, 'A4 Laven Street', 'Toronto', 'AL', 'M2X3B1', '64753561234','sameul.honey@gmail.com', 125);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323682, 'Ruby', 'Yul', to_date('10/11/1992','mm/dd/yy'), 'F', 26, 'C6 Thorne Street', 'Toronto', 'ON', 'M2R32X', '6475352132','ruby.yul@gmail.com', 125);

-- doctors
INSERT INTO doctor(doctor_id, doctorlicense_expiry, employee_id) VALUES (141524, to_date('03/06/2030','mm/dd/yy'), 323952);
INSERT INTO doctor(doctor_id, doctorlicense_expiry, employee_id) VALUES (141525, to_date('03/12/2030','mm/dd/yy'), 323678);
INSERT INTO doctor(doctor_id, doctorlicense_expiry, employee_id) VALUES (141526, to_date('04/06/2012','mm/dd/yy'), 323679);

-- nurses
INSERT INTO nurse(nurse_id, nurselicense_expiry, employee_id) VALUES(555879, to_date('09/10/2025','mm/dd/yy'), 323680);
INSERT INTO nurse(nurse_id, nurselicense_expiry, employee_id) VALUES(555880, to_date('09/11/2022','mm/dd/yy'), 323681);
INSERT INTO nurse(nurse_id, nurselicense_expiry, employee_id) VALUES(555881, to_date('10/10/2023','mm/dd/yy'), 323682);

-- patients
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567890', 'Ann', 'Smith', to_date('01/28/1997','mm/dd/yy'), 'F', '22','1290 Bayview Rd.','Toronto', 'ON', 'M1B2X4', '6471234567','ann.smith97@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567891', 'Bob', 'Brown', to_date('02/21/2000','mm/dd/yy'), 'M', '20','11 Clifton St.','Toronto', 'ON', 'M2C1L5','6471234568','bob.brown00@hotmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567892', 'Carl', 'Jones', to_date('07/11/1999','mm/dd/yy'), 'M', '21','103 Roadhouse Rd.','Oakville', 'ON', 'L6L2X6','4162578564','carl.jones99@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567893', 'Dan', 'Miller', to_date('04/07/1998','mm/dd/yy'), 'M', '22','56 Steeling Ave.','Pickering', 'ON', 'L1V0A1','4162874587','dan.miller98@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567894', 'Eve', 'Williams', to_date('01/22/1998','mm/dd/yy'), 'F', '22','23 Greentint Cres.','Markham', 'ON', 'L1C3P2','6478985674','eve.williams22@hotmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567895', 'Stan', 'Murphy', to_date('01/29/1999','mm/dd/yy'), 'M', '30','1111 Bayview Rd.','Toronto', 'ON', 'M1B2X4', '6471212311','stan.murphy@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567896', 'Alice', 'Yum', to_date('03/21/2020','mm/dd/yy'), 'F', '21','11 Steeling St.','Toronto', 'ON', 'M2C3CD','6471234231','yum.alice@hotmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567897', 'Steve', 'Jan', to_date('07/12/1920','mm/dd/yy'), 'M', '23','2 Ins Street','Oakville', 'ON', 'L6L2X','4162532313','steve.jan@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567898', 'Mike', 'Lanny', to_date('08/07/1990','mm/dd/yy'), 'M', '40','55 Steeling Ave.','Pickering', 'ON', 'L1DED','4162875561','mike.lanny@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567899', 'Camy', 'Hun', to_date('01/30/1932','mm/dd/yy'), 'F', '30','2 Hopkins Street','Markham', 'ON', 'L1QD2P','6478983164','camy.hun@hotmail.com');


---------------
--- QUERIES ---
---------------
-- Hospital Table   
-- get all the existing hospitals
SELECT * FROM hospital;
-- get  hospitals where hos
SELECT * FROM hospital WHERE address_city = 'Toronto';

-- Employee Table
-- get employee with hospital ids, 123
SELECT * FROM employee ORDER BY hospital_id;
SELECT * FROM employee WHERE hospital_id = 123;
-- sort employees by age
SELECT * FROM employee ORDER BY date_of_birth ASC;
-- counts 
SELECT COUNT(employee_id), hospital_id FROM employee GROUP BY hospital_id;

-- Doctor Table
-- find doctor_id from doctors with expired ID's 
SELECT doctor_id FROM doctor WHERE doctorlicense_expiry < TRUNC(CURRENT_DATE());
-- 

-- Nurse Table
-- find nurse_id from nurses with ID's that expire in the next 5 years
SELECT nurse_id FROM nurse WHERE nurselicense_expiry < to_date('01/01/2025','mm/dd/yyyy'); 

-- Patient Table
-- find all the shorties from toronto ;) 
SELECT * FROM patient WHERE gender = 'F' AND address_city = 'Toronto' AND age < 22 ; 

-- Appointment Table
--

-- Invoice Table
--

-- Diagnosis Table
--

-- Medicine Table
--

-- Perscription Table
--

-- Medical History Table 
--

-- don't know if these work!!

-- select the appointments for this week 
SELECT * FROM appointment WHERE appointment_date >= '10/18/2020' AND appointment_date < '10/25/2020' ; 

-- select invoices that are more than $1000
SELECT * FROM invoice WHERE amount_owed >= 1000 ; 

-- select all patients whose diagnosis mentions cancer
SELECT * FROM diagnosis WHERE results LIKE '%cancer%' ; 

-- select all medicines made by Sinopharm
SELECT * FROM medicine WHERE manufacturer='Sinopharm' ; 

-- select prescriptions that include medicine_id = 123 
SELECT * FROM prescription WHERE medicine_id=123 ; 

-- sort medical histories by healthcard_no 
SELECT * FROM medical_history ORDER BY healthcard_no DESC ;
