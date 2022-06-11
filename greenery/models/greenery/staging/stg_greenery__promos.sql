/*
    materializing as view based on recommendation from link below
    https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
*/
{{ config(materialized='view') }}

/* 
    renaming a few columns for clarity
*/ 
with src as (
    select * 
    from {{ source('greenery', 'promos') }}
),
renamed as (
    select
        promo_id,
        discount as promo_discount,
        status as promo_price
    from src
)
select * 
from renamed
