CREATE DATABASE IF NOT EXISTS  area_operaciones;
USE AREA_OPERACIONES;
# Creacion de tablas;
CREATE TABLE IF NOT EXISTS Areas_Comunes(
Building TEXT,
Floor TEXT,
ID_Room_Name varchar(255) NOT NULL,
Area_m2 decimal(12,2),
primary key (ID_Room_Name));

TRUNCATE Areas_Comunes;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Tabla_areas_comunes.csv' IGNORE
INTO TABLE Areas_Comunes
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Building,Floor,ID_Room_Name,Area_m2);

CREATE TABLE IF NOT EXISTS Centro_Costo(
Cost_Center_Id VARCHAR (255) NOT NULL,
Cost_Center_Standard_List TEXT,
Cost_Center_Group TEXT,
primary key (Cost_Center_Id));

TRUNCATE Centro_Costo;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Tabla Centros de Costo.csv' IGNORE
INTO TABLE Centro_Costo
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Cost_Center_Id,Cost_Center_Standard_List,Cost_Center_Group);


CREATE TABLE IF NOT EXISTS Areas_Comunes_Mes (
ID_ACM INT AUTO_INCREMENT,
Period date,
Building TEXT,
Floor TEXT,
Cost_Center_Id varchar(255) NOT NULL,
Room_Name varchar(255) NOT NULL,
Weight INT,
primary key (ID_ACM),
foreign key (Room_Name) references Areas_Comunes (ID_Room_Name),
foreign key (Cost_Center_Id) references Centro_Costo (Cost_Center_Id));

TRUNCATE Areas_Comunes_Mes;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Areas_Comunes_Mes.csv' IGNORE
INTO TABLE Areas_Comunes_Mes
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Cost_Center_Id,Period,Building,Floor,Room_Name,Weight);

drop table arriendos;
CREATE TABLE IF NOT EXISTS Arriendos (
ID_Arriendo INT AUTO_INCREMENT,
anual_Update date,
Building VARCHAR(255) NOT NULL,
Floor VARCHAR (255) NOT NULL,
Total_Area_m2 decimal(12,2),
Total_Rent decimal(12,2),
Seats INT,
PRIMARY KEY (ID_Arriendo));

TRUNCATE Arriendos;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Arriendo.csv' IGNORE
INTO TABLE Arriendos
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(anual_Update,Building,Floor,Total_Area_m2,Total_Rent,Seats);

drop table seats_input;
CREATE TABLE IF NOT EXISTS seats_input (
ID_Seats INT AUTO_INCREMENT,
Period date,
Building text,
Floor text,
Seats_Used INT,
Cost_Center_Id VARCHAR (255),
PRIMARY KEY (ID_Seats),
foreign key (Cost_Center_Id) references Centro_Costo (Cost_Center_Id));

TRUNCATE seats_input;
LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\prueba.csv' IGNORE
INTO TABLE seats_input
FIELDS TERMINATED BY ',' 
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Cost_Center_Id,Period,Building,Floor, Seats_Used);