USE AREA_OPERACIONES;
select * from areas_comunes;
select * from areas_comunes_mes;
select * from arriendos;
select* from centro_costo;
select * from Seats_Input;
select (SI.period) AS Month_Year, SI.Building, SI.Floor,si.cost_center_id, co.cost_center_standard_list , si.seats_used
from Seats_Input as SI
left join centro_costo as co ON SI.cost_center_id = co.cost_center_id 
where si.cost_center_id like '%1001-001%';



# saber por cada edificio y piso cual es area comun total
Select building, floor, format(sum(area_m2),2)  as Area_comun from areas_comunes 
group by building , floor;


/*
Select year(anual_update) as Ys, a.Building, a.floor, total_Area_m2,Total_rent,Area_comun,seats from Arriendos a 
left join As Total_area_comun  TA ON a.Building=TA.Building AND a.floor=TA.floor;*/