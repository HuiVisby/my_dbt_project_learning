with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

order_payments as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(sum(payments.amount_dollars), 0) as order_total_dollars

    from orders
    left join payments using (order_id)
    group by 1, 2, 3, 4

)

select * from order_payments
