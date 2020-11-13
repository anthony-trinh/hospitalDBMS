#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "jamanipo/07226166@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
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
	exit;
EOF
