{{
  config(
    materialized='table'
  )
}}

select 
   count(*) as num_items,
   stg_orders.order_id,
   stg_orders.user_id,
   stg_orders.promo_id,
   stg_orders.address_id,
   stg_orders.created_at_UTC,
   stg_orders.order_cost,
   stg_orders.shipping_cost, 
   stg_orders.order_total,
   stg_orders.tracking_id,
   stg_orders.shipping_service, 
   stg_orders.estimated_delivery_at_UTC,
   stg_orders.delivered_at_UTC,
   stg_orders.status 

   from {{ ref('stg_orders') }}
left join {{ ref('stg_order_items') }}
  on  stg_orders.order_id = stg_order_items.order_id
group by      stg_orders.order_id,
   stg_orders.user_id,
   stg_orders.promo_id,
   stg_orders.address_id,
   stg_orders.created_at_UTC,
   stg_orders.order_cost,
   stg_orders.shipping_cost, 
   stg_orders.order_total,
   stg_orders.tracking_id,
   stg_orders.shipping_service, 
   stg_orders.estimated_delivery_at_UTC,
   stg_orders.delivered_at_UTC,
   stg_orders.status 