
    
    

with child as (
    select pickup_date as from_field
    from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
    where pickup_date is not null
),

parent as (
    select date_key as to_field
    from "sqldb-taxi-platform"."bronze_silver"."dim_date"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


