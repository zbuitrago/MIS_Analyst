with

VALOR1 AS (Select building, floor,sum(area_m2) as Area_comun from areas_comunes 
group by building , floor),

VALOR2 AS (Select year(anual_update) as Ys, a.Building, a.Floor, Total_Area_m2 as Total_Area,Total_rent,Area_comun,seats, (Total_rent/total_Area_m2) as Valor_m2 
from Arriendos a left join VALOR1 as tap
 ON a.Building=tap.Building AND a.floor=tap.floor),
 
VALOR3 AS (select Ys, Building, Floor,Total_rent,Total_Area, Valor_m2 ,Area_comun ,
(valor_m2*Area_comun) as Valor_area_comun, seats
from valor2 )

SELECT Ys, Building, Floor,Total_rent,Total_Area, Valor_m2 ,Area_comun,Valor_area_comun,(Total_rent- Valor_area_comun) as valor_seat, seats FROM VALOR3;




