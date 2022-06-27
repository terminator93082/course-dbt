{{
  config(
    materialized='table'
  )
}}

{% set events = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') %}



SELECT 
session_id,
created_at_utc,
user_id, 
product_id

{% for event_type in events %}
      , {{aggregate_events(event_type)}} as {{event_type}}
{% endfor %}    

FROM {{ ref('stg_events') }}
group by 1,2,3,4