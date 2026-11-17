-- PUZZLE: la fuente del mart y la regla de negocio necesitan correccion.
-- Pista: el mart depende del modelo intermedio, no directamente del staging.
select
    order_id,
    customer_name,
    product_name,
    quantity,
    unit_price,
    total_amount,
    status
from {{ ref('stg_orders') }}                -- PIEZA 3: corregir ref()
where status != 'PENDING'                    -- PIEZA 4: excluir tambien CANCELLED
