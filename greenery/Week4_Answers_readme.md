## Week 4 Project Answers

### PART 1: dbt Snapshots

#### Run dbt snapshot again and see how the data has changed for those two orders

  ```
select * from dbt.snapshots."orders_snapshot" where dbt_valid_to is not null
   ```

### PART 2: Modeling challenge

#### Please create any additional dbt models needed to help answer these questions from our product team, and put your answers in a README in your repo.

  ```
with event_counts as (

  select 
      count(*),
      sum (case when page_view>0 then 1 else 0 end) as sessions_with_pageviews,
      sum(case when add_to_cart>0 then 1 else 0 end) as sessions_with_addtocart,
      sum(case when checkout>0 then 1 else 0 end) as sessions_with_checkout 
      from "dbt"."dbt_vijay_r"."fct_sessions"
  )
,
funnel as (

  select 
    (sessions_with_addtocart::numeric/sessions_with_pageviews::numeric) as pageview_to_cart,
    (sessions_with_checkout::numeric/sessions_with_addtocart::numeric) as cart_to_checkout

    from event_counts
)

select * from funnel
   ```

#### Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. Please reference the course content if you have questions.

  - **answer: /workspace/course-dbt/greenery/models/exposures.yml


### PART 3: Reflection questions

#### 3b: Setting up for production / scheduled dbt run of your project

  - **answer:Steps would be daily do a dbt run and dbt test. If test fails then have alerts piped to Looker dashboard and from there to Slack. Orchestrate using dbt cloud initially and if project complexity goes beyond dbt then consider dagster. Would be interested to knowing dbt run times, so can then improve the runs by focusing on models that take most time**