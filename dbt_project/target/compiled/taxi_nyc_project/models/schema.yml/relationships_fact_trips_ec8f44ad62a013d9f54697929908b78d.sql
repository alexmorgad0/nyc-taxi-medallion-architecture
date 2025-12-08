
    
    

with child as (
    select payment_type as from_field
    from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
    where payment_type is not null
),

parent as (
    select payment_type as to_field
    from "sqldb-taxi-platform"."bronze_silver"."dim_payment_type"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


