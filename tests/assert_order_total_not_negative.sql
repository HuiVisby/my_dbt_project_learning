select *
from {{ ref('fct_orders') }}
where order_total_dollars < 0
