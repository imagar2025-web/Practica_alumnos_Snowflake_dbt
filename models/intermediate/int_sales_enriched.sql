-- PUZZLE: hay DOS referencias equivocadas en los JOIN.
-- Pista: c es cliente y p es producto; comprueba las columnas de cada staging.
select
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.unit_price,
    o.quantity * p.unit_price as total_amount,
    o.status
from {{ ref('stg_orders') }} o
join {{ ref('stg_products') }} c using (customer_id)  -- PIEZA 1: corregir ref()
join {{ ref('stg_customers') }} p using (product_id) -- PIEZA 2: corregir ref()
