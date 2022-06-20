{{
  config (
    materialized = 'table'
  )
}}

with users as (
    select * 
    from {{ ref('stg_greenery__users') }}
),
addresses as (
    select * 
    from {{ ref('stg_greenery__addresses') }}
),
joined as (
  select 
    u.user_id,
    u.first_name,
    u.last_name, 
    u.email,
    u.phone_number, 
    u.created_at, 
    u.updated_at,
    a.address_id, 
    a.address,
    a.zipcode, 
    a.state, 
    a.country
  from users u
  left join addresses a 
    on u.address_id = a.address_id
)
select * 
from joined