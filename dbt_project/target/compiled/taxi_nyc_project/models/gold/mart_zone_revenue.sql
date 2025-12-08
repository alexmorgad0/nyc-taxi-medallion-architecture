

select
    pu_location_id             as pickup_zone_id,
    count(*)                   as trip_count,
    sum(total_amount)          as total_revenue
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
group by
    pu_location_id;