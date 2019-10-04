# create database area_operaciones
USE AREA_OPERACIONES;

# drop table seats_input_mes;

#select * from seats_input_mes;
CREATE TABLE seats_input_mes (
ID INT AUTO_INCREMENT,
Period date,
Building TEXT,
Floor TEXT,
Seats_Used TEXT,
Cost_Center_Id TEXT,
PRIMARY KEY (ID));

TRUNCATE seats_input_mes;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Tabla_Seats_Input_Mes.csv' IGNORE
INTO TABLE seats_input_mes
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Period,Building,Floor,Seats_Used,Cost_Center_Id);


