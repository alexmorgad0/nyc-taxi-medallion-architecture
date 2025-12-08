
  
    USE [sqldb-taxi-platform];
    USE [sqldb-taxi-platform];
    
    

    

    
    USE [sqldb-taxi-platform];
    EXEC('
        create view "bronze_gold"."mart_tip_by_payment_type__dbt_tmp__dbt_tmp_vw" as 

select
    d.payment_type_desc   as payment_type,
    avg(f.tip_pct)        as avg_tip_pct
from "sqldb-taxi-platform"."bronze_silver"."fact_trips" f
join "sqldb-taxi-platform"."bronze_silver"."dim_payment_type" d
    on f.payment_type = d.payment_type
where f.tip_pct is not null
group by
    d.payment_type_desc;;
    ')

EXEC('
            SELECT * INTO "sqldb-taxi-platform"."bronze_gold"."mart_tip_by_payment_type__dbt_tmp" FROM "sqldb-taxi-platform"."bronze_gold"."mart_tip_by_payment_type__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS bronze_gold.mart_tip_by_payment_type__dbt_tmp__dbt_tmp_vw')



    
    use [sqldb-taxi-platform];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'bronze_gold_mart_tip_by_payment_type__dbt_tmp_cci'
        AND object_id=object_id('bronze_gold_mart_tip_by_payment_type__dbt_tmp')
    )
    DROP index "bronze_gold"."mart_tip_by_payment_type__dbt_tmp".bronze_gold_mart_tip_by_payment_type__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX bronze_gold_mart_tip_by_payment_type__dbt_tmp_cci
    ON "bronze_gold"."mart_tip_by_payment_type__dbt_tmp"

   


  