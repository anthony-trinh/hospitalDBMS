#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "jamanipo/07226166@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
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
    exit;
EOF