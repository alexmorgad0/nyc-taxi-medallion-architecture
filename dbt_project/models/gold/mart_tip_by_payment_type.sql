{{ config(materialized='table') }}

select
    d.payment_type_desc   as payment_type,
    avg(f.tip_pct)        as avg_tip_pct
from {{ ref('fact_trips') }} f
join {{ ref('dim_payment_type') }} d
    on f.payment_type = d.payment_type
where f.tip_pct is not null
group by
    d.payment_type_desc;
