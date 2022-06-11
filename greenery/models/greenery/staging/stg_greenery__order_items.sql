/*
    materializing as view based on recommendation from link below
    https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
*/
{{ config(materialized='view') }}

/* 
    renaming a  column for clarity
*/ 
with src as (
    select * 
    from {{ source('greenery', 'order_items') }}
),
renamed as (
    select
        order_id,
        product_id,
        quantity as order_quantity
    from src
)
select * 
from renamed
