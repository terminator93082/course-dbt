{{
  config(
    materialized='table'
  )
}}

with session_length as (

select 
   session_id, 
   min (created_at_utc) as first_event,
   max (created_at_utc) as last_event

   from {{ ref('stg_events') }}
   group by 1
)

select 
  int_sessions_events_basic_agg.session_id, 
  int_sessions_events_basic_agg.user_id, 
  stg_users.first_name,
  stg_users.last_name,
  stg_users.email,
  int_sessions_events_basic_agg.page_view,
  int_sessions_events_basic_agg.add_to_cart,
  int_sessions_events_basic_agg.checkout,
  int_sessions_events_basic_agg.package_shipped,
  session_length.first_event as first_session_event,
  session_length.last_event as last_session_event,
  (DATE_PART('day', session_length.last_event::timestamp - session_length.first_event::timestamp) * 24 + 
               DATE_PART('hour', session_length.last_event::timestamp - session_length.first_event::timestamp)) * 60 +
               DATE_PART('minute', session_length.last_event::timestamp - session_length.first_event::timestamp)
  as session_length_minutes

from {{ ref('int_sessions_events_basic_agg') }}
left join {{ ref('stg_users') }}
  on  int_sessions_events_basic_agg.user_id = stg_users.user_id
left join session_length 
   on int_sessions_events_basic_agg.session_id=session_length.session_id