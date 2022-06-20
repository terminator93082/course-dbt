SELECT *
FROM {{ ref('stg_orders') }}
WHERE delivered_at_UTC < created_at_UTC 
/* checking if there are any instances where the delivery date is before the date the order was placed which wouldn't make sense logically and indicate some sort of data issue */