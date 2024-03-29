USE AREA_OPERACIONES;

with 
# saber por cada edificio y piso cual es area comun total
Total_area_comun_piso as (Select building, floor, format(sum(area_m2),2)  as Area_comun from areas_comunes 
group by building , floor),

#Resumen_tabla_area_silla_piso as 
valor1 as  (Select year(anual_update) as Ys, a.Building, a.Floor, format(Total_Area_m2,2) as Total_Area,format(Total_rent,2)as Total_rent,Area_comun,seats, format((Total_rent/total_Area_m2),2) as Valor_m2 
from Arriendos a left join Total_area_comun_piso as tap
 ON a.Building=tap.Building AND a.floor=tap.floor)

#valor2 as (
select Ys, Building, Floor,Total_rent,Total_Area, Valor_m2 ,Area_comun ,
format((valor_m2*Area_comun),2) as Valor_area_comun, seats
from valor1;


/*
select Ys, Building, floor,Total_Area,Total_rent,  Valor_m2 ,Area_comun, Valor_area_comun, (Total_rent- Valor_area_comun) as valor_seats,seats
from valor2;
/*
select  YS, Building, floor, Total_area, Total_rent, seats, valor_m2, valor_area_comun, 
format((Total_rent-valor_area_comun),2) as Valor_seats
from valor ;*/

#select , (total_Area_m2-Area_comun) from Resumen_tabla_area_silla_piso

/*select (SI.period) AS Month_Year, SI.Building, SI.Floor,si.cost_center_id, co.cost_center_standard_list , si.seats_used
from Seats_Input as SI
left join centro_costo as co ON SI.cost_center_id = co.cost_center_id ;*/

#select * from areas_comunes_mes;
*/