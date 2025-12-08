
  
    USE [sqldb-taxi-platform];
    USE [sqldb-taxi-platform];
    
    

    

    
    USE [sqldb-taxi-platform];
    EXEC('
        create view "bronze_bronze"."stg_trips__dbt_tmp__dbt_tmp_vw" as 

select
    cast(VendorID as int)                             as vendor_id,
    cast(tpep_pickup_datetime as datetime2)           as pickup_datetime,
    cast(tpep_dropoff_datetime as datetime2)          as dropoff_datetime,
    cast(passenger_count as int)                      as passenger_count,
    cast(trip_distance as float)                      as trip_distance,
    cast(RatecodeID as int)                           as rate_code_id,
    upper(store_and_fwd_flag)                         as store_and_fwd_flag,
    cast(PULocationID as int)                         as pu_location_id,
    cast(DOLocationID as int)                         as do_location_id,
    cast(payment_type as int)                         as payment_type,
    cast(fare_amount as decimal(10,2))                as fare_amount,
    cast(extra as decimal(10,2))                      as extra,
    cast(mta_tax as decimal(10,2))                    as mta_tax,
    cast(tip_amount as decimal(10,2))                 as tip_amount,
    cast(tolls_amount as decimal(10,2))               as tolls_amount,
    cast(improvement_surcharge as decimal(10,2))      as improvement_surcharge,
    cast(total_amount as decimal(10,2))               as total_amount,
    cast(congestion_surcharge as decimal(10,2))       as congestion_surcharge,
    cast(Airport_fee as decimal(10,2))                as airport_fee,
    cast(cbd_congestion_fee as decimal(10,2))         as cbd_congestion_fee
from raw.yellow_trips_2025_08
where
    trip_distance >= 0
    and fare_amount >= 0
    and total_amount >= 0
    and tpep_pickup_datetime is not null
    and tpep_dropoff_datetime is not null
    and tpep_dropoff_datetime >= tpep_pickup_datetime;;
    ')

EXEC('
            SELECT * INTO "sqldb-taxi-platform"."bronze_bronze"."stg_trips__dbt_tmp" FROM "sqldb-taxi-platform"."bronze_bronze"."stg_trips__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS bronze_bronze.stg_trips__dbt_tmp__dbt_tmp_vw')



    
    use [sqldb-taxi-platform];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'bronze_bronze_stg_trips__dbt_tmp_cci'
        AND object_id=object_id('bronze_bronze_stg_trips__dbt_tmp')
    )
    DROP index "bronze_bronze"."stg_trips__dbt_tmp".bronze_bronze_stg_trips__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX bronze_bronze_stg_trips__dbt_tmp_cci
    ON "bronze_bronze"."stg_trips__dbt_tmp"

   


  