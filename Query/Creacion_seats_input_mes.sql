# create database area_operaciones
USE AREA_OPERACIONES;



#select * from seats_input_mes;
CREATE TABLE seats_input_mes (
ID INT AUTO_INCREMENT,
Period date,
Building TEXT,
Floor TEXT,
Seats_Used TEXT,
Cost_Center_Id varchar(10),
PRIMARY KEY (ID));
#foreign key (Cost_Center_Id) references Centro_Costo (Cost_Center_Id));
 drop table seats_input_mes;
TRUNCATE seats_input_mes;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\prueba.csv' IGNORE
INTO TABLE seats_input_mes
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Cost_Center_Id,Period,Building,Floor,Seats_Used);
select * from seats_input_mes
where cost_center_id ='1070-001';


select * from seats_input_mes;