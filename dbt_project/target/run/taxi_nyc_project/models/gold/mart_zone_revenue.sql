
  
    USE [sqldb-taxi-platform];
    USE [sqldb-taxi-platform];
    
    

    

    
    USE [sqldb-taxi-platform];
    EXEC('
        create view "bronze_gold"."mart_zone_revenue__dbt_tmp__dbt_tmp_vw" as 

select
    pu_location_id             as pickup_zone_id,
    count(*)                   as trip_count,
    sum(total_amount)          as total_revenue
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
group by
    pu_location_id;;
    ')

EXEC('
            SELECT * INTO "sqldb-taxi-platform"."bronze_gold"."mart_zone_revenue__dbt_tmp" FROM "sqldb-taxi-platform"."bronze_gold"."mart_zone_revenue__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS bronze_gold.mart_zone_revenue__dbt_tmp__dbt_tmp_vw')



    
    use [sqldb-taxi-platform];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'bronze_gold_mart_zone_revenue__dbt_tmp_cci'
        AND object_id=object_id('bronze_gold_mart_zone_revenue__dbt_tmp')
    )
    DROP index "bronze_gold"."mart_zone_revenue__dbt_tmp".bronze_gold_mart_zone_revenue__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX bronze_gold_mart_zone_revenue__dbt_tmp_cci
    ON "bronze_gold"."mart_zone_revenue__dbt_tmp"

   


  