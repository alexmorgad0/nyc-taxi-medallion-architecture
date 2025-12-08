
  
    USE [sqldb-taxi-platform];
    USE [sqldb-taxi-platform];
    
    

    

    
    USE [sqldb-taxi-platform];
    EXEC('
        create view "bronze_silver"."fact_trips__dbt_tmp__dbt_tmp_vw" as 

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
from base;;
    ')

EXEC('
            SELECT * INTO "sqldb-taxi-platform"."bronze_silver"."fact_trips__dbt_tmp" FROM "sqldb-taxi-platform"."bronze_silver"."fact_trips__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS bronze_silver.fact_trips__dbt_tmp__dbt_tmp_vw')



    
    use [sqldb-taxi-platform];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'bronze_silver_fact_trips__dbt_tmp_cci'
        AND object_id=object_id('bronze_silver_fact_trips__dbt_tmp')
    )
    DROP index "bronze_silver"."fact_trips__dbt_tmp".bronze_silver_fact_trips__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX bronze_silver_fact_trips__dbt_tmp_cci
    ON "bronze_silver"."fact_trips__dbt_tmp"

   


  