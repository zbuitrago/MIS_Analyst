CREATE TEMPORARY TABLE IF NOT EXISTS Reporte AS  WITH    

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
Tabla1 as (SELECT ID_Seats,date_format(si.period,'%b %Y') AS Month_Year,si.building,si.floor,Cost_center_id,
(valor_seat*seats_used) as Rent_Seats, seats_used FROM seats_input si
left join valor4 v on year( si.period)=v.ys and si.building=v.building and si.floor=v.floor),

tabla2 as (select ID_Seats,Month_Year,building, floor, cc.Cost_center_id,cost_center_standard_list,Rent_Seats, seats_used from tabla1 t1
left join centro_costo cc on t1.Cost_center_id=cc.Cost_center_id),

# agrupado por building,floor,costid
tabla3 as (select ID_ACM,date_format(period,'%b %Y') AS Month_Year,period,Building,floor,Cost_center_id 
from areas_comunes_mes ac
group by Month_Year,Building,floor,cost_center_id),

# contiene join entre areas_comunes_mes_
tabla4 as (select ID_ACM,Month_Year,t3.Building,t3.floor,Cost_center_id,(valor_area_comun) as Rent_Common_Areas from tabla3 t3
left join valor4 v on year(t3.period)=v.ys and t3.building=v.building and t3.floor=v.floor
order by Month_Year,t3.building, t3.floor),

tabla5 as (select ID_ACM ,Month_Year, building, floor, cc.Cost_center_id,cost_center_standard_list,Rent_Common_Areas from tabla4 t4
left join centro_costo cc on t4.Cost_center_id=cc.Cost_center_id),


tabla6 as (select t2.Month_Year, t2.building, t2.floor, t2.Cost_center_id,t2.cost_center_standard_list,Rent_Seats,t5.Rent_Common_Areas,seats_used
from tabla5 t5
right join tabla2  t2 on  ID_Seats=ID_ACM),


tabla7 as (select t5.Month_Year, t5.building, t5.floor, t5.Cost_center_id,t5.cost_center_standard_list,t2.Rent_Seats,t5.Rent_Common_Areas,seats_used from tabla5 t5
left join tabla2  t2 on  ID_Seats=ID_ACM),


tabla8 as ((select * from tabla6 )
union
(select * from tabla7)),

tabla9 as (select Month_Year, Building, floor, Cost_center_id, Cost_center_standard_list,
(case WHEN Rent_Seats is null  then 0 else Rent_Seats end) as Rent_Seats,
(case WHEN rent_common_areas is null  then 0 else rent_common_areas end) as Rent_Common_Areas,
(case WHEN Seats_used is null  then 0 else Seats_used end) as Seats_used
from tabla8
order by month_year,building,floor)

select Month_Year, Building, floor, Cost_center_id, Cost_center_standard_list,format(Rent_Seats,2) as Rent_Seats,format(Rent_Common_Areas,2) as Rent_Common_Areas, format((Rent_Seats+Rent_Common_Areas),2) as Total_Rent,Seats_used
from tabla9;


select * from reporte;





