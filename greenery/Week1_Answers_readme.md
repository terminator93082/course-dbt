1. How many users do we have?
 - [query] select count(*) from dbt_vijay_r.stg_users
 - [answer] 130
 
2. On average, how many orders do we receive per hour?
- [query] select (select count(*) from dbt_vijay_r.stg_orders)*3600/(select extract(epoch from ((select max(created_at_utc) from dbt_vijay_r.stg_orders as maxct) - (select min(created_at_utc) from dbt_vijay_r.stg_orders as minct))))

- [answer] 7.5325593661428965 , ~ 7.5 orders an hour

3. On average, how long does an order take from being placed to being delivered?
- [query] select avg(delivered_at_utc - created_at_utc)  from dbt_vijay_r.stg_orders  where delivered_at_utc is not null 
- [answer] 3 days 21:24:11.803279

4a. How many users have only made one purchase? 
- [query] select count(*) from  (select count(*),user_id from dbt_vijay_r.stg_orders group by user_id having count(*)=1) as orders_grouped_by_user
- [answer] 25

4b. Two purchases? 
- [query] select count(*) from  (select count(*),user_id from dbt_vijay_r.stg_orders group by user_id having count(*)=2) as orders_grouped_by_user
- [answer] 28

4c. Three+ purchases?
- [query] select count(*) from (select count(*),user_id from dbt_vijay_r.stg_orders group by user_id having count(*)>=3) as orders_grouped_by_user
- [answer] 71

   Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

5. On average, how many unique sessions do we have per hour?
- [query] select avg(a2.num_unique_sessions) from 
            (
            select a1.specific_hr, count(a1.*) as num_unique_sessions from

            (select date_trunc('hour', created_at_utc) as specific_hr, session_id, count(*) 
                  from dbt_vijay_r.stg_events group by session_id,date_trunc('hour', created_at_utc)) a1
                  
            group by a1.specific_hr
            ) a2

- [answer] 16.3275862068965517, ~16 unqiue session per hour
