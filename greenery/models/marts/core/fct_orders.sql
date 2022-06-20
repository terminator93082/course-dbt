{{
  config(
    materialized='table'
  )
}}

select 
   int_orders_orders_items.num_items,
   int_orders_orders_items.order_id,
   int_orders_orders_items.user_id,
   int_orders_orders_items.promo_id,
   int_orders_orders_items.address_id,
   int_orders_orders_items.created_at_UTC,
   int_orders_orders_items.order_cost,
   int_orders_orders_items.shipping_cost, 
   int_orders_orders_items.order_total,
   int_orders_orders_items.tracking_id,
   int_orders_orders_items.shipping_service, 
   int_orders_orders_items.estimated_delivery_at_UTC,
   int_orders_orders_items.delivered_at_UTC,
   int_orders_orders_items.status,
   (current_date - int_orders_orders_items.created_at_UTC::date) as days_since_order

from {{ ref('int_orders_orders_items') }}

