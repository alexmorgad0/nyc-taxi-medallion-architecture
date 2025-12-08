
  
    USE [sqldb-taxi-platform];
    USE [sqldb-taxi-platform];
    
    

    

    
    USE [sqldb-taxi-platform];
    EXEC('
        create view "bronze_silver"."dim_payment_type__dbt_tmp__dbt_tmp_vw" as 

select * from (
    values
        (1, ''Credit card''),
        (2, ''Cash''),
        (3, ''No charge''),
        (4, ''Dispute''),
        (5, ''Unknown''),
        (6, ''Voided trip'')
) as t(payment_type, payment_type_desc);
    ')

EXEC('
            SELECT * INTO "sqldb-taxi-platform"."bronze_silver"."dim_payment_type__dbt_tmp" FROM "sqldb-taxi-platform"."bronze_silver"."dim_payment_type__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS bronze_silver.dim_payment_type__dbt_tmp__dbt_tmp_vw')



    
    use [sqldb-taxi-platform];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'bronze_silver_dim_payment_type__dbt_tmp_cci'
        AND object_id=object_id('bronze_silver_dim_payment_type__dbt_tmp')
    )
    DROP index "bronze_silver"."dim_payment_type__dbt_tmp".bronze_silver_dim_payment_type__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX bronze_silver_dim_payment_type__dbt_tmp_cci
    ON "bronze_silver"."dim_payment_type__dbt_tmp"

   


  