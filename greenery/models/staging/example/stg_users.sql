{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    email ,
    phone_number ,
    created_at AS created_at_UTC,
    updated_at AS updated_at_UTC,
    address_id 

FROM {{ source('tutorial', 'users') }}