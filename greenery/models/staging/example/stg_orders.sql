{{
  config(
    materialized='table'
  )
}}

SELECT 
  order_id,
  user_id,
  promo_id,
  address_id,
  created_at as created_at_UTC,
  order_cost,
  shipping_cost, 
  order_total,
  tracking_id,
  shipping_service, 
  estimated_delivery_at as estimated_delivery_at_UTC,
  delivered_at as delivered_at_UTC,
  status 
FROM {{ source('tutorial', 'orders') }}