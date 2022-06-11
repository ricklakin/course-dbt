/*
    materializing as view based on recommendation from link below
    https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging
*/
{{ config(materialized='view') }}

/* 
    need to adjust zip code
    some zip codes start with 0 and are integers
*/ 
with src as (
    select * 
    from {{ source('greenery', 'addresses') }}
),
recast as (
    select
        address_id,
        address,
        case 
            when zipcode < 10000
            then concat('0', zipcode::varchar)
            else zipcode::varchar
            end as zipcode, 
        state, 
        country
    from src
)
select *
from recast
