with

VALOR1 AS (Select building, floor,sum(area_m2) as Area_comun from areas_comunes 
group by building , floor),

VALOR2 AS (Select year(anual_update) as Ys, a.Building, a.Floor, Total_Area_m2 as Total_Area,Total_rent,Area_comun,seats, (Total_rent/total_Area_m2) as Valor_m2 
from Arriendos a left join VALOR1 as tap
ON a.Building=tap.Building AND a.floor=tap.floor),
 
 VALOR3 AS (select Ys, Building, Floor,Total_rent,Total_Area, Valor_m2 ,Area_comun ,
(valor_m2*Area_comun) as Valor_area_comun, seats
from valor2 ),
#VALOR4 =El valor puesto de trabajo y m2
VALOR4 AS (SELECT Ys, Building, Floor,Total_rent,Total_Area, Valor_m2 ,Area_comun,Valor_area_comun,((Total_rent- Valor_area_comun)/seats )as valor_seat, seats FROM VALOR3),

# contiene join entre seats_input & costos
Tabla1 as (SELECT date_format(si.period,'%b %Y') AS Month_Year,si.building,si.floor,Cost_center_id,
(valor_seat*seats_used) as Rent_Seats, seats_used FROM seats_input si
left join valor4 v on year( si.period)=v.ys and si.building=v.building and si.floor=v.floor),


tabla2 as (select Month_Year,building, floor, cc.Cost_center_id,cost_center_standard_list,Rent_Seats, seats_used from tabla1 t1
left join centro_costo cc on t1.Cost_center_id=cc.Cost_center_id)
select *from tabla2;
/*
# tabla3 contiene el registro join de centro_costo & areas_comunes_mes
tabla3 as (select date_format(period,'%b %Y') AS Month_Year,period, building, floor, cc.Cost_center_id,cost_center_standard_list from areas_comunes_mes ac
left join centro_costo cc on ac.Cost_center_id=cc.Cost_center_id
group by building,floor,cost_center_id,cc.Cost_center_id),

tabla4 as (select Month_Year,t3.building, t3.floor, t3.Cost_center_id,cost_center_standard_list,(valor_area_comun) as Rent_Common_Areas from tabla3 t3
left join valor4 v on year(t3.period)=v.ys and t3.building=v.building and t3.floor=v.floor
order by Month_Year,t3.building, t3.floor)
*/

