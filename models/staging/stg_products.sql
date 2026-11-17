-- El staging de productos esta CORRECTO.
select
    product_id,
    trim(product_name) as product_name,
    unit_price
from {{ ref('products') }}
