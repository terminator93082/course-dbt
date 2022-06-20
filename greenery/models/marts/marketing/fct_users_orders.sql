{{
  config(
    materialized='table'
  )
}}

with last_order_for_user as  (

SELECT 
   order_user_id, 
   order_id,
   order_created_at_utc

FROM {{ ref('int_users_orders') }} c
WHERE order_id in 
    (SELECT 
      order_id as latest_order_id
      FROM {{ ref('int_users_orders') }} b
      INNER JOIN (
                  SELECT order_user_id,
                         MAX(order_created_at_utc) as latest_order_created_at_utc
                  FROM {{ ref('int_users_orders') }}
                  GROUP BY order_user_id
                 ) a 
                ON 
                  a.order_user_id = b.order_user_id AND 
                  a.latest_order_created_at_utc = b.order_created_at_utc
 
  )

)


select 
   int_users_orders.order_user_id,
   count(*) as num_orders,
   sum(order_total) as total_orders_amount,
   avg(order_total) as average_spent,
   avg(num_items_in_order) as avg_basket_size,
   min(days_since_order) as days_since_last_order
   from {{ ref('int_users_orders') }}
left join last_order_for_user
  on  int_users_orders.order_user_id = last_order_for_user.order_user_id
group by   int_users_orders.order_user_id--,days_since_last_order
