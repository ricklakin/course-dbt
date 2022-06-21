select *
from {{ ref('dim_orders') }}
where length(phone_number::text) != 12