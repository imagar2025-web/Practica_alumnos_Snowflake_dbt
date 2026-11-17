-- Test singular didactico: devuelve filas si el mart tiene estados no facturables.
-- Para pasar, esta consulta debe devolver CERO filas.
select *
from {{ ref('fct_sales') }}
where status not in ('SHIPPED', 'DELIVERED')
