{% macro sp_insert_r(table_name) %}

    --Firstly we will fetch the columns of the table 
    {% set dest_cols = adapter.get_columns_in_relation(ref(table_name)) %}

    {% set dest_cols_csv = dest_cols | map(attribute='quoted') | join(', ') %}

    {% set sql1 %}
    insert into {{target.schema}}.{{ table_name }} ({{ dest_cols_csv }}) 
     
  
     (
with customers as (

   select * from {{ ref ('demo_model') }}

),

orders as (

    select * from {{ ref('order') }}

),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        customers.customer_id as cus_id,
        customers.first_name as first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)
    
)
     

select cus_id,first_name,number_of_orders  from final 


);
    {% endset %}

{% do run_query(sql1) %}

{% endmacro%}
