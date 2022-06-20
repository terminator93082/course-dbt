{{
  config(
    materialized='table'
  )
}}

select 
    fct_orders.order_id as order_id,
    fct_orders.user_id as order_user_id,
    stg_users.first_name as user_first_name,
    stg_users.last_name as user_last_name,
    fct_orders.created_at_UTC as order_created_at_UTC,
    fct_orders.order_total as order_total,
    fct_orders.days_since_order as days_since_order,
    fct_orders.num_items as num_items_in_order
from {{ ref('fct_orders') }}
left join {{ ref('stg_users') }}
  on  fct_orders.user_id = stg_users.user_id