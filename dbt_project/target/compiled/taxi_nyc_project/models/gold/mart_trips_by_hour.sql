

select
    pickup_hour      as hour_of_day,
    pickup_day_name  as day_of_week,
    count(*)         as trip_count
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
group by
    pickup_hour,
    pickup_day_name;