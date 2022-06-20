# Solutions: Week Two

## Part 1 - Models
### Question 1
What is our user repeat rate? <br>
Repeat Rate = Users who purchased 2 or more times / users who purchased <br>
Answer: 99/124 = 79.8%

```sql
with purchasers as (
  select 
    user_id,
    count(distinct order_id) as order_count
  from dbt_rick_l.stg_greenery__orders
  group by user_id
),
counts as (
  select 
    sum(case when order_count >= 2 then 1 else 0 end) as repeat_purchasers_count,
    count(distinct user_id) as purchasers_count
  from purchasers
)
select 
  cast(repeat_purchasers_count as float) / cast(purchasers_count as float) as repeat_rate
from counts;
```

### Question 2
What are good indicators of a user who will likely purchase again? <br>

Some indicators could include: <br>
- Users who have visited the platform multiple times.
- Users who have never returned any of their purchases.
- Users who didn't have to wait too long for their purchases to arrive.


What about indicators of users who are likely NOT to purchase again? <br> 


If you had more data, what features would you want to look into to answer this question? <br>


## Part 2 - Tests
### Question 1