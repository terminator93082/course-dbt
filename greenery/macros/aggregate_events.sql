{% macro aggregate_events(event_type) %}
   sum(case when event_type='{{event_type}}' then 1 else 0 end) 
{% endmacro %}