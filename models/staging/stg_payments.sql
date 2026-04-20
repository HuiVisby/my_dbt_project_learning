with source as (

    select * from {{ source('jaffle_shop', 'raw_payments') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['id', 'payment_method']) }}
                                as payment_surrogate_key,
        id                      as payment_id,
        order_id,
        payment_method,
        amount,
        {{ cents_to_dollars('amount') }} as amount_dollars

    from source

)

select * from renamed
