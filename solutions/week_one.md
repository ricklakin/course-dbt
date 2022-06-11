# Solutions: Week One

### Question 1
How many users do we have?
Answer: 130

```sql
select count(distinct user_id) as user_count
from dbt_rick_l.stg_greenery__users;
```

### Question 2
On average, how many orders do we receive per hour?
Answer: 7.52

```sql
with date_hour_sums as (
  select date_trunc('HOUR', created_at) as created_at_date_hour,
    count(*) as order_count
  from dbt_rick_l.stg_greenery__orders
  group by 1
)
select avg(order_count) as avg_orders_per_hour
from date_hour_sums;
```

### Question 3
On average, how long does an order take from being placed to being delivered?
Answer: 3.89 days

```sql
with delivered_orders as (
  select order_id,
    created_at,
    delivered_at,
    extract(day from delivered_at - created_at) as days_part_delta,
    extract(hour from delivered_at - created_at) as hours_part_delta
  from dbt_rick_l.stg_greenery__orders
  where order_status = 'delivered'
    and delivered_at > created_at
),
calculated_time_to_delivery as (
  select order_id,
    (24 * days_part_delta) + hours_part_delta as hours_to_delivery,
    ((24 * days_part_delta) + hours_part_delta) / 24 as days_to_delivery
  from delivered_orders
)
select avg(days_to_delivery) as avg_days_to_delivery
from calculated_time_to_delivery;
```

### Question 4
How many users have only made one purchase? Two purchases? Three+ purchases?
Answer: 1 Purchase - 25, 2 Purchases - 28, 3+ Purchases - 71

```sql
with user_orders_summary as (
  select user_id,
    count(*) as order_count
  from dbt_rick_l.stg_greenery__orders
  group by 1
)
select
  case when order_count = 1 then '1 Purchase'
       when order_count = 2 then '2 Purchases'
       when order_count >= 3 then '3+ Purchases'
       end as order_count_flag,
  count(distinct user_id) as user_count
from user_orders_summary
group by 1
order by 1;
```

### Question 5
On average, how many unique sessions do we have per hour?
Answer: 16.33

```sql
with date_hour_sums as (
  select date_trunc('HOUR', created_at) as created_at_date_hour,
    count(distinct session_id) as session_count
  from dbt_rick_l.stg_greenery__events
  group by 1
)
select avg(session_count) as avg_orders_per_hour
from date_hour_sums;
```


