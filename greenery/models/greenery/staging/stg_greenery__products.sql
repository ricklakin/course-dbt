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
    from {{ source('greenery', 'products') }}
),
renamed as (
    select
        product_id,
        name as product_name,
        price as product_price, 
        inventory as product_inventory
    from src
)
select * 
from renamed
