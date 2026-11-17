-- El staging de clientes esta CORRECTO.
select
    customer_id,
    trim(customer_name) as customer_name
from {{ ref('customers') }}
