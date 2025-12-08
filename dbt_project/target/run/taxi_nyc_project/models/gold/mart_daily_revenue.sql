
  
    USE [sqldb-taxi-platform];
    USE [sqldb-taxi-platform];
    
    

    

    
    USE [sqldb-taxi-platform];
    EXEC('
        create view "bronze_gold"."mart_daily_revenue__dbt_tmp__dbt_tmp_vw" as 

select
    pickup_date                as trip_date,
    count(*)                   as trip_count,
    sum(total_amount)          as total_revenue,
    avg(total_amount)          as avg_revenue_per_trip
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
group by
    pickup_date;;
    ')

EXEC('
            SELECT * INTO "sqldb-taxi-platform"."bronze_gold"."mart_daily_revenue__dbt_tmp" FROM "sqldb-taxi-platform"."bronze_gold"."mart_daily_revenue__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS bronze_gold.mart_daily_revenue__dbt_tmp__dbt_tmp_vw')



    
    use [sqldb-taxi-platform];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'bronze_gold_mart_daily_revenue__dbt_tmp_cci'
        AND object_id=object_id('bronze_gold_mart_daily_revenue__dbt_tmp')
    )
    DROP index "bronze_gold"."mart_daily_revenue__dbt_tmp".bronze_gold_mart_daily_revenue__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX bronze_gold_mart_daily_revenue__dbt_tmp_cci
    ON "bronze_gold"."mart_daily_revenue__dbt_tmp"

   


  