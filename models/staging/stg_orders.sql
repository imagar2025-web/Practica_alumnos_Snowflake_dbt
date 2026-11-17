-- El staging de pedidos esta CORRECTO. Sirve de referencia.
select
    order_id,
    customer_id,
    product_id,
    quantity,
    upper(trim(status)) as status
from {{ ref('orders') }}
