#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "jamanipo/07226166@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
   SELECT email
    FROM appointment a, patient p WHERE 
        p.f_name = 'Ann'
        AND p.l_name = 'Smith'
        AND a.healthcard_no = p.healthcard_no;   
  
    FROM appointment a, patient p, doctor d, nurse n, employee e WHERE 
        p.f_name = 'Carl' AND p.l_name = 'Jones'
        AND e.f_name = 'Mindy' AND e.l_name = 'Ramirez'
        and d.employee_id = e.employee_id
        AND a.doctor_id = d.doctor_id
        AND a.nurse_id = n.nurse_id
        AND a.healthcard_no = p.healthcard_no;
   
    SELECT e.f_name AS D_firstname, e.l_name AS D_lastname, p.f_name as P_firstname, p.l_name as P_lastname
    FROM appointment a, patient p, doctor d, employee e
    WHERE a.appointment_id =  10031
        AND a.doctor_id = d.doctor_id
        AND d.employee_id = e.employee_id
        AND a.healthcard_no = p.healthcard_no; 

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
        
    SELECT employee_id FROM nurse
        UNION
    SELECT employee_id FROM doctor;

    SELECT * FROM employee
    MINUS
    (SELECT e.*
    FROM employee e, hospital h
    WHERE h.hospital_name = 'Toronto General Hospital'
    AND h.hospital_id = e.hospital_id);

    SELECT 'Total number of patients: ', COUNT(healthcard_no)
    FROM patient ;

    SELECT COUNT(medicine_id), manufacturer 
    FROM medicine
    GROUP BY manufacturer;

    SELECT COUNT(employee_id) AS "# of Employees", hospital_id 
    FROM employee 
    GROUP BY hospital_id;

    SELECT 'Average cost of medicine is from sinopharm is ', AVG(price)
    FROM medicine 
    WHERE manufacturer='Sinopharm' ;
    exit;
EOF
