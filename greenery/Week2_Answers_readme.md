## Week 2 Project Answers

We were approached by the marketing team to answer some questions about Greenery’s users! Use your staging models you created in Week 1 to answer their questions:

### Q1) What is our user repeat rate?

*Repeat Rate = Users who purchased 2 or more times / users who purchased*

  - **answer: 0.80**
  - **query for Q1:**
   ```
        with orders_cohort as (

            select user_id
                    , count (distinct order_id) as user_orders
                from dbt.dbt_vijay_r.stg_orders 
            group by 1
        ),
        users_bucket as (
                select 
                user_id
                , (user_orders >=2)::int as has_two_plus_purchases
                from orders_cohort
        )

        select 
            sum(has_two_plus_purchases)::float/count(distinct user_id) as repeat_rate
            from users_bucket
   ```

### Q2) What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

*NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.*

  - **answer:
    * Good indicators of a user who will likely purchase again: Higher number for previous purchases, Purchased recently, high average session length 
    * Indicators of users who are likely not to purchase again: Lower number for previous purchases, Has not purchased recently, low average session length 
    * Features to better answer question: user age, user gender, user household size, user device(s)**



### Q3) More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:

*Core Marketing Product Within each marts folder, create intermediate models and dimension/fact models. NOTE: think about what metrics might be particularly useful for these business units, and build dbt models using greenery’s data For example, some core datasets could include fact_orders, dim_products, and dim_users The marketing mart could contain a model like user_order_facts which contains order information at the user level The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data*

- **answer: Please review marts folder in github**

### Q4) Explain the marts models you added. Why did you organize the models in the way you did?

- **answer: I created a order facts table in core as the facts grouping the items can be useful to multiple downstream uses. I created an intermediate table there which first summarizes items, and then the final facts table which has a helper function to get "days since". By keeping each "layer" have small discrete logic, I felt it makes the logic easier to follow and debug as things get more complex**

### Q5) Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

Paste in an image of your DAG from the docs. These commands will help you see the full DAG
$ dbt docs generate 
$ dbt docs serve --no-browser

- **answer: Uploaded as part of the submission**

(Part 2) Tests 

We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

### Q6) What assumptions are you making about each model? (i.e. why are you adding each test?)

- **answer: Depending on the model, I looked at what would be generally expected such as positive_values, unique, not null etc**

### Q7) Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

- **answer: Yes I was expecting one of my intermediate tables to have a unique id, and when it failed, I discovered a bug in my code. In another case, a test failes, and I am not sure why, so for now I temporarily removed that check**

*Apply these changes to your github repo*

### Q8) Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

- **answer: I believe the way to do this would be run "dbt test" on a daily schedule, perhaps through Airflow or some other approach to run this on a regular basis. In addition, I belived dbt can auto alert on slack, but I am not sure how to go about doing that**