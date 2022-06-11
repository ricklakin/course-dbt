/*
    materializing as view based on recommendation from link below
    https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
*/
{{ config(materialized='view') }}

/* 
    decided to not rename or recast columns
*/ 
select
    event_id,
    session_id,
    user_id, 
    event_type, 
    page_url, 
    created_at, 
    order_id, 
    product_id
from {{ source('greenery', 'events') }}
