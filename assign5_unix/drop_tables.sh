#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "jamanipo/07226166@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
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
	exit;
EOF
