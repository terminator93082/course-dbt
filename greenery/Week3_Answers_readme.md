## Week 3 Project Answers

### PART 1: Create new models to answer the first two questions (answer questions in README file)

#### What is our overall conversion rate?

  - **answer: 0.62**

  ```
select 
     count(distinct case when checkout = 1 then session_id end)::float/count(distinct session_id)::float 
from dbt.dbt_vijay_r.int_sessions_events_basic_agg
   ```

#### What is our conversion rate by product?

  ```
--- assume add to cart has NO cart abandonment
select 
      product_id
      , sum(add_to_cart) / count(distinct session_id) as conversion_rate_by_product      
from dbt.dbt_vijay_r.int_sessions_events_basic_agg
group by 1

  ```

### PART 2: Create a macro to simplify part of a model(s).

  - **answer: In intermediate/int_sessions_events_basic_agg.sql, use of my own aggregate_events macro, and dbt_utils.get_column_values**

### PART 3: Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

  - **answer: Verified by running query that reporting role has access to SELECT**

  ```
SELECT grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name='int_sessions_events_basic_agg'

  ```


### PART 4: Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

  - **answer: Installed dbt-utils and tried out the accepted_range test on the quantity column in stg_order_items and also use dbt_utils.get_column_values in intermediate/int_sessions_events_basic_agg.sql**

