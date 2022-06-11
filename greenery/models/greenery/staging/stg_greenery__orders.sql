/*
    materializing as view based on recommendation from link below
    https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
*/
{{ config(materialized='view') }}

/* 
    renaming one column
*/ 
with src as (
    select * 
    from {{ source('greenery', 'orders') }}
),
renamed as (
    select
        order_id,
        user_id,
        promo_id, 
        address_id, 
        created_at, 
        order_cost, 
        shipping_cost, 
        order_total,
        tracking_id, 
        shipping_service, 
        estimated_delivery_at, 
        delivered_at, 
        status as order_status
    from src
)
select *
from renamed
