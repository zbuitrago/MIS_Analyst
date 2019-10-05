USE AREA_OPERACIONES;
with 
# saber por cada edificio y piso cual es area comun total
Total_area_comun_piso as (Select building, floor, format(sum(area_m2),2)  as Area_comun from areas_comunes 
group by building , floor)

#Resumen_tabla_area_silla_piso as 
Select year(anual_update) as Ys, a.Building, a.floor, format(total_Area_m2,2) as total_Area,format(Total_rent,2)as Total_rent,Area_comun,seats, format((Total_rent/total_Area_m2),2) as Valor_m2 from Arriendos a 
left join Total_area_comun_piso as tap ON a.Building=tap.Building AND a.floor=tap.floor;

#select , (total_Area_m2-Area_comun) from Resumen_tabla_area_silla_piso

/*select (SI.period) AS Month_Year, SI.Building, SI.Floor,si.cost_center_id, co.cost_center_standard_list , si.seats_used
from Seats_Input as SI
left join centro_costo as co ON SI.cost_center_id = co.cost_center_id ;*/

#select * from areas_comunes_mes;
select year(AC.period) ys, Cost_center_id from areas_comunes_mes AC
left join Resumen_tabla_area_silla_piso R ON AC.building = r.building and ac.floor=r.floor and r.ys=ys  ;