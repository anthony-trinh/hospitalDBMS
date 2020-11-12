/*  CPS510 A4
    Anthony Trinh, 500831193 
    Amiel Castillo, 500883624
    Jose Manipon, 500906166
    Section 2, group 28 */

--------------
--- TABLES ---
--------------
-- drop created entity and relation tables 
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
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE hospital CASCADE CONSTRAINTS;

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
    appointment_time INT NOT NULL,
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
    amount_owed FLOAT NOT NULL,
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
    iupac_name VARCHAR2(256) NOT NULL, 
    generic_name VARCHAR2(64) NOT NULL,
    inventory INT NOT NULL, 
    price FLOAT NOT NULL,
    expiration_date DATE NOT NULL,
    manufacturer VARCHAR2(32) NOT NULL,
    PRIMARY KEY(medicine_id)
); 

CREATE TABLE prescription ( 
    prescription_no INT NOT NULL,
    dosage INT NOT NULL,
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

--------------
---- DATA ----
--------------
-- deletion of data
DELETE FROM hospital;
DELETE FROM employee;
DELETE FROM doctor;
DELETE FROM nurse;
DELETE FROM patient;
DELETE FROM appointment;
DELETE FROM medicine;
DELETE FROM invoice;
DELETE FROM diagnosis;
DELETE FROM prescription;
DELETE FROM medical_history;

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
    VALUES (323952, 'Andrew', 'Musak', to_date('07/12/1987','mm/dd/yyyy'), 'M', 33, '121 Collins Rd.', 'Toronto', 'ON', 'M1V1N3', '4168794561','dr.andrew.musak33@gmail.com', 123);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323678, 'Mindy', 'Ramirez', to_date('10/10/1990','mm/dd/yyyy'), 'F', 30, '126 Sisao St.', 'Toronto', 'ON', 'M1P4R2', '6475213125','mindy.ramirez@gmail.com', 124);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323679, 'John', 'Cooper', to_date('08/10/1989','mm/dd/yyyy'), 'M', 27, 'B9 Prospect Street', 'Toronto', 'ON', 'M1PX13', '6475213256','cooper.john@gmail.com', 124);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323680, 'Michelle', 'Stanley', to_date('10/06/1991','mm/dd/yyyy'), 'F', 30, '202 Enble Street', 'Toronto', 'ON', 'M1D13C', '6473125676','stanley.michelle@gmail.com', 123);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323681, 'Samuel', 'Honey', to_date('10/12/1990','mm/dd/yyyy'), 'M', 31, 'A4 Laven Street', 'Toronto', 'AL', 'M2X3B1', '64753561234','samuel.honey@gmail.com', 125);
INSERT INTO employee (employee_id, f_name, l_name, date_of_birth, gender, age, address_street, address_city, address_province, address_postalcode, phone, email, hospital_id) 
    VALUES (323682, 'Ruby', 'Yul', to_date('10/11/1992','mm/dd/yyyy'), 'F', 26, 'C6 Thorne Street', 'Toronto', 'ON', 'M2R32X', '6475352132','ruby.yul@gmail.com', 125);
-- doctors
INSERT INTO doctor(doctor_id, doctorlicense_expiry, employee_id) VALUES (141524, to_date('03/06/2030','mm/dd/yyyy'), 323952);
INSERT INTO doctor(doctor_id, doctorlicense_expiry, employee_id) VALUES (141525, to_date('03/12/2020','mm/dd/yyyy'), 323678);
INSERT INTO doctor(doctor_id, doctorlicense_expiry, employee_id) VALUES (141526, to_date('04/06/2012','mm/dd/yyyy'), 323679);
-- nurses
INSERT INTO nurse(nurse_id, nurselicense_expiry, employee_id) VALUES(555879, to_date('09/10/2025','mm/dd/yyyy'), 323680);
INSERT INTO nurse(nurse_id, nurselicense_expiry, employee_id) VALUES(555880, to_date('09/11/2022','mm/dd/yyyy'), 323681);
INSERT INTO nurse(nurse_id, nurselicense_expiry, employee_id) VALUES(555881, to_date('10/10/2023','mm/dd/yyyy'), 323682);
-- patients
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567890', 'Ann', 'Smith', to_date('01/28/1997','mm/dd/yyyy'), 'F', '22','1290 Bayview Rd.','Toronto', 'ON', 'M1B2X4', '6471234567','ann.smith97@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567891', 'Bob', 'Brown', to_date('02/21/2000','mm/dd/yyyy'), 'M', '20','11 Clifton St.','Toronto', 'ON', 'M2C1L5','6471234568','bob.brown00@hotmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567892', 'Carl', 'Jones', to_date('07/11/1999','mm/dd/yyyy'), 'M', '21','103 Roadhouse Rd.','Oakville', 'ON', 'L6L2X6','4162578564','carl.jones99@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567893', 'Dan', 'Miller', to_date('04/07/1998','mm/dd/yyyy'), 'M', '22','56 Steeling Ave.','Pickering', 'ON', 'L1V0A1','4162874587','dan.miller98@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567894', 'Eve', 'Williams', to_date('01/22/1998','mm/dd/yyyy'), 'F', '22','23 Greentint Cres.','Markham', 'ON', 'L1C3P2','6478985674','eve.williams22@hotmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567895', 'Stan', 'Murphy', to_date('01/29/1999','mm/dd/yyyy'), 'M', '30','1111 Bayview Rd.','Toronto', 'ON', 'M1B2X4', '6471212311','stan.murphy@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567896', 'Alice', 'Yum', to_date('03/21/2020','mm/dd/yyyy'), 'F', '21','11 Steeling St.','Toronto', 'ON', 'M2C3CD','6471234231','yum.alice@hotmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567897', 'Steve', 'Jan', to_date('07/12/1920','mm/dd/yyyy'), 'M', '23','2 Ins Street','Oakville', 'ON', 'L6L2X','4162532313','steve.jan@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567898', 'Mike', 'Lanny', to_date('08/07/1990','mm/dd/yyyy'), 'M', '40','55 Steeling Ave.','Pickering', 'ON', 'L1DED','4162875561','mike.lanny@gmail.com');
INSERT INTO patient (healthcard_no,f_name,l_name, date_of_birth, gender,age,address_street,address_city,address_province,address_postalcode,phone, email) 
    VALUES ('1234567899', 'Camy', 'Hun', to_date('01/30/1932','mm/dd/yyyy'), 'F', '30','2 Hopkins Street','Markham', 'ON', 'L1QD2P','6478983164','camy.hun@hotmail.com');
-- appointments
INSERT INTO appointment (appointment_id,appointment_date,appointment_time,room_no,nurse_id,healthcard_no,doctor_id,hospital_id) 
    VALUES (10031, to_date('12/12/2020', 'mm/dd/yyyy'), 1300, 1, 555879, 1234567890, 141524, 123) ; 
INSERT INTO appointment (appointment_id,appointment_date,appointment_time,room_no,nurse_id,healthcard_no,doctor_id,hospital_id) 
    VALUES (10012, to_date('10/20/2020', 'mm/dd/yyyy'), 1400, 2, 555880, 1234567891, 141525, 124) ; 
INSERT INTO appointment (appointment_id,appointment_date,appointment_time,room_no,nurse_id,healthcard_no,doctor_id,hospital_id) 
    VALUES (10013, to_date('10/22/2020', 'mm/dd/yyyy'), 1500, 3, 555881, 1234567892, 141526, 125);
-- medicine
INSERT INTO medicine(medicine_id, iupac_name, generic_name, inventory, price, expiration_date, manufacturer)
    VALUES(191919,'N-(4-hydroxyphenyl)acetamide','acetaminophen',500,5.00,to_date('01/01/2030','mm/dd/yyyy'), 'Tylenol') ; 
INSERT INTO medicine(medicine_id, iupac_name, generic_name, inventory, price, expiration_date, manufacturer)
    VALUES(191920,'8-Chloro-1-methyl-6-phenyl-4H-[1,2,4]triazolo[4,3-a][1,4]benzodiazepine','alprazolam',200,50.00,to_date('02/02/2030','mm/dd/yyyy'), 'Tylenol') ; 
INSERT INTO medicine(medicine_id, iupac_name, generic_name, inventory, price, expiration_date, manufacturer)
    VALUES(191921,'(S,S)-2-methylamino-1-phenylpropan-1-ol', 'pseudoephedrine', 100, 50.00, to_date('10/22/2030','mm/dd/yyyy'), 'Johnson and Johnson') ;
-- invoices
INSERT INTO invoice (invoice_no, medicine_id, date_issued, amount_owed, appointment_id)
    VALUES (111112,3, to_date('10/20/2020', 'mm/dd/yyyy'), 100.00, 10012) ; 
INSERT INTO invoice (invoice_no,medicine_id,date_issued,amount_owed,appointment_id)
    VALUES (111113,3, to_date('10/22/2020', 'mm/dd/yyyy'), 10.00, 10013) ;  
-- diagnosis
INSERT INTO diagnosis (diagnosis_id, results, appointment_id)
    VALUES(0123456, 'Stomach cancer',  10012) ; 
INSERT INTO diagnosis (diagnosis_id, results, appointment_id)
    VALUES(0123457, 'Covid-19',  10013) ;
-- prescription 
INSERT INTO prescription(prescription_no, dosage,date_issued,appointment_id, medicine_id, diagnosis_id)
    VALUES (1231231, '20', to_date('10/20/2020','mm/dd/yyyy'), 10012, 191919, 0123456) ;
INSERT INTO prescription(prescription_no, dosage,date_issued,appointment_id, medicine_id, diagnosis_id)
    VALUES (1231232, '50', to_date('10/22/2020', 'mm/dd/yyyy'), 10013, 191919, 0123457) ;
-- medical history
INSERT INTO medical_history(healthcard_no, appointment_id, diagnosis_id, medical_desc)
    VALUES(1234567891, 10012, 0123456, 'This guy has stomach cancer, he is allergic to tylonel so prescribe him something else') ;
INSERT INTO medical_history(healthcard_no, appointment_id, diagnosis_id, medical_desc)
    VALUES(1234567892, 10013, 0123457, 'Make sure they stay at home for two weeks') ;
    
---------------
--- QUERIES ---
---------------
-- Hospital Table   
-- get all the existing hospitals
SELECT * FROM hospital;
-- get  hospitals located in toronto
SELECT * FROM hospital WHERE address_city = 'Toronto';

-- Employee Table
SELECT * FROM hospital;
-- get employee with hospital ids, 123
SELECT * FROM employee ORDER BY hospital_id;
SELECT * FROM employee WHERE hospital_id = 123;
-- sort employees by age
SELECT * FROM employee ORDER BY date_of_birth ASC;
-- counts 
SELECT COUNT(employee_id) AS "# of Employees", hospital_id FROM employee GROUP BY hospital_id;

-- Doctor Table
SELECT * FROM doctor;
-- find doctor_id from doctors with ID's that expired in 2020 
SELECT doctor_id FROM doctor WHERE doctorlicense_expiry < to_date('01/01/2020','mm/dd/yyyy');

-- Nurse Table
SELECT * FROM nurse;
-- find nurse_id from nurses with ID's that expire in the next 5 years
SELECT nurse_id FROM nurse WHERE nurselicense_expiry < to_date('01/01/2025','mm/dd/yyyy'); 

-- Patient Table
SELECT * FROM patient;
-- find all the women age 22 from toronto  
SELECT * FROM patient WHERE gender = 'F' AND address_city = 'Toronto' AND age < 22 ; 

-- Appointment Table
SELECT * FROM appointment ;
-- find appointments taken during the November 18 to 25, in the year 2020
SELECT * FROM appointment WHERE appointment_date >= to_date('10/18/2020', 'mm/dd/yyyy') AND appointment_date < to_date('10/25/2020','mm/dd/yyyy') ; 

-- Invoice Table
SELECT * FROM invoice ;
--find all invoices owing 100 or more 
SELECT * FROM invoice WHERE amount_owed >= 100 ; 

-- Diagnosis Table 
SELECT * FROM DIAGNOSIS ; 
--find all diagnosises that include cancer
SELECT * FROM diagnosis WHERE results LIKE '%cancer%' ; 

-- Medicine Table
SELECT * FROM medicine ; 
--find all drugs made by johnson and johnson 
SELECT * FROM medicine WHERE manufacturer='Johnson and Johnson' ; 

-- Prescription Table--
SELECT * FROM prescription ; 
--find all prescriptions for medicine_id='191919', and sort them descending by dosage
SELECT * FROM prescription WHERE medicine_id = '191919' ORDER BY dosage DESC ;

-- Medical History Table --
SELECT * FROM medical_history ;
-- sort medical histories by healthcard_no 
SELECT * FROM medical_history ORDER BY healthcard_no ASC ;

-- ADVANCED QUERIES    
-- JOIN queries
-- gets email from given name in appointment
SELECT email
FROM appointment a, patient p WHERE 
    p.f_name = 'Ann'
    AND p.l_name = 'Smith'
    AND a.healthcard_no = p.healthcard_no;   
-- gets appointment id, of Patient, Carl Jones and Doctor, Mindy Ramirez
SELECT appointment_id 
FROM appointment a, patient p, doctor d, nurse n, employee e WHERE 
    p.f_name = 'Carl' AND p.l_name = 'Jones'
    AND e.f_name = 'Mindy' AND e.l_name = 'Ramirez'
    and d.employee_id = e.employee_id
    AND a.doctor_id = d.doctor_id
    AND a.nurse_id = n.nurse_id
    AND a.healthcard_no = p.healthcard_no;
-- gets doctor and pateint for appointment_id
SELECT e.f_name AS D_firstname, e.l_name AS D_lastname, p.f_name as P_firstname, p.l_name as P_lastname
FROM appointment a, patient p, doctor d, employee e
WHERE a.appointment_id =  10031
    AND a.doctor_id = d.doctor_id
    AND d.employee_id = e.employee_id
    AND a.healthcard_no = p.healthcard_no; 
    
-- EXISTS queries, implements intersection
SELECT generic_name, inventory, price, expiration_date, manufacturer
FROM medicine 
    WHERE EXISTS
    (SELECT prescription_no 
     FROM prescription 
     WHERE prescription.medicine_id = medicine.medicine_id);

SELECT e.f_name, e.f_name
FROM employee e
WHERE EXISTS
    (SELECT e.f_name, e.f_name
    FROM employee e, nurse n
    WHERE 
    n.employee_id = 323680
    AND e.employee_id = n.employee_id);
    
SELECT p1.f_name, p1.l_name
FROM patient p1
WHERE EXISTS
    (SELECT p2.f_name, p2.l_name
    FROM patient p2, appointment a, doctor d, employee e
    WHERE e.f_name = 'John' AND e.l_name = 'Cooper'
          AND e.employee_id = d.employee_id
          AND a.doctor_id = d.doctor_id
          AND a.healthcard_no = p2.healthcard_no); 
    
-- UNION queries
SELECT employee_id FROM nurse
    UNION
SELECT employee_id FROM doctor;

-- MINUS queries
-- select all employees not working in Toronto General Hospital
SELECT * FROM employee
MINUS
(SELECT e.*
FROM employee e, hospital h
WHERE h.hospital_name = 'Toronto General Hospital'
AND h.hospital_id = e.hospital_id);

-- COUNT
SELECT 'Total number of patients: ', COUNT(healthcard_no)
FROM patient ;

-- GROUP BY
SELECT COUNT(medicine_id), manufacturer 
FROM medicine
GROUP BY manufacturer;

SELECT COUNT(employee_id) AS "# of Employees", hospital_id 
FROM employee 
GROUP BY hospital_id;

-- OTHER queries
SELECT 'Average cost of medicine is from sinopharm is ', AVG(price)
FROM medicine 
WHERE manufacturer='Sinopharm' ;


---------------
---- VIEWS ----
---------------
DROP VIEW JOHNSON_AND_JOHNSON_MEDICINES ;
CREATE VIEW JOHNSON_AND_JOHNSON_MEDICINES AS 
SELECT medicine_id, iupac_name,generic_name,expiration_date,manufacturer,inventory
FROM medicine
WHERE manufacturer='Johnson and Johnson';
    --Selecting from above view
    SELECT * FROM JOHNSON_AND_JOHNSON_MEDICINES ;
    --Select medicines from view which expire in 2020
    SELECT * FROM JOHNSON_AND_JOHNSON_MEDICINES WHERE expiration_date < to_date('01/01/2021', 'mm/dd/yyyy') ; 
    --Select from johnson_and_johnson_medcines, medcines that are low in stock
    SELECT * FROM JOHNSON_AND_JOHNSON_MEDICINES WHERE inventory <= 100 ; 
    SELECT * FROM medicine MINUS SELECT * FROM JOHNSON_AND_JOHNSON_MEDICINES ;

DROP VIEW TORONTO_HOSPITALS ;
CREATE VIEW TORONTO_HOSPITALS AS
SELECT hospital_id, hospital_name, address_street,address_city,address_province, address_postalcode, address_country, phone
FROM hospital
WHERE address_city='Toronto' ;
    ---Selecting from the view
    SELECT * FROM TORONTO_HOSPITALS;
    
DROP VIEW ELDERLY_PATIENTS ;
CREATE VIEW ELDERLY_PATIENTS AS
SELECT *
FROM patient
WHERE age >= 65 ;
    --Selecting the view
    SELECT * FROM ELDERLY_PATIENTS ;
    --Order ELDERLY_PATIENTS by age 
    SELECT * FROM ELDERLY_PATIENTS ORDER BY age DESC ;