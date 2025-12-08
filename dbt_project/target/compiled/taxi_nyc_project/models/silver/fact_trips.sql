

with base as (

    select
        -- simple surrogate key
        cast(
            row_number() over (
                order by pickup_datetime, pu_location_id, do_location_id
            ) as bigint
        )                                           as trip_id,

        -- time fields
        pickup_datetime,
        dropoff_datetime,
        datediff(minute, pickup_datetime, dropoff_datetime)
                                                    as trip_duration_minutes,
        cast(pickup_datetime as date)               as pickup_date,
        datepart(hour, pickup_datetime)             as pickup_hour,
        datename(weekday, pickup_datetime)          as pickup_day_name,
        datepart(weekday, pickup_datetime)          as pickup_day_of_week,

        -- original numeric fields
        passenger_count,
        trip_distance,
        rate_code_id,
        pu_location_id,
        do_location_id,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        cbd_congestion_fee

    from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"

)

select
    *,
    case 
        when fare_amount > 0 
            then cast(tip_amount / fare_amount * 100.0 as float)
        else null
    end                                             as tip_pct
from base;