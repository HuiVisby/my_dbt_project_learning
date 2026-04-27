with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select
        customer_id,
        min(order_date)                 as first_order_date,
        max(order_date)                 as most_recent_order_date,
        count(order_id)                 as number_of_orders,
        sum(order_total_dollars)        as lifetime_value_dollars

    from {{ ref('int_orders_with_payments') }}
    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        orders.first_order_date,
        orders.most_recent_order_date,
        coalesce(orders.number_of_orders, 0)        as number_of_orders,
        coalesce(orders.lifetime_value_dollars, 0)  as lifetime_value_dollars

    from customers
    left join orders using (customer_id)

)

select * from final
