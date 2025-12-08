

select
    pickup_date                as trip_date,
    count(*)                   as trip_count,
    sum(total_amount)          as total_revenue,
    avg(total_amount)          as avg_revenue_per_trip
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
group by
    pickup_date;