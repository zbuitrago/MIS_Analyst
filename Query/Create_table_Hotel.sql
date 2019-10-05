create database pruebas;
use pruebas;
CREATE TABLE IF NOT EXISTS Hotel (
Id_hotel int auto_increment,
Nombre_Hotel text,
Id_ciudad int,
num_estrellas int,
distancia_centro int,
Id_tipo_alojamiento int,
Id_habitacion int,
piscina char,
primary key (Id_hotel),
foreign key (Id_ciudad) references ciudad (Id_ciudad),
foreign key (Id_tipo_alojamiento ) references tipo_alojamiento  (Id_tipo_alojamiento));

Create table if not exists habitaciones (
Id_habitacion int auto_increment,
id_hotel int,
metros_cuadrados int,
Num_camas_sencillas int,
Num_camas_dobles int,
primary key (Id_habitacion),
foreign key (Id_hotel) references Hotel (Id_hotel)
);


create table if not exists ciudad (
id_ciudad int auto_increment not null,
nombre_ciudad text,
primary key (id_ciudad));

create table if not exists tipo_alojamiento (
Id_tipo_alojamiento  int auto_increment not null,
descripcion  text,
primary key (Id_tipo_alojamiento));

insert into tipo_alojamiento values (1,'hotel'); 
insert into ciudad values (1,'Bucaramanga'); 
insert into habitaciones values (1,1,40,2,1); 
insert into hotel values (1,'La Serrania',1,3,2,1,1,1); 
select *from hotel;
select*from habitaciones;
select*from ciudad;
select*from tipo_alojamiento;
select *
from hotel ho
left join habitaciones ha on ho.id_hotel = ha.id_hotel
left join tipo_alojamiento ta on ho.id_tipo_alojamiento = ta.id_tipo_alojamiento
left join ciudad c on ho.id_ciudad=c.id_ciudad;
