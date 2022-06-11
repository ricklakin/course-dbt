/*
    materializing as view based on recommendation from link below
    https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
*/
{{ config(materialized='view') }}

/* 
    decided to not rename or recast columns
*/ 
select
    user_id,
    first_name,
    last_name, 
    email, 
    phone_number, 
    created_at, 
    updated_at, 
    address_id
from {{ source('greenery', 'users') }}
