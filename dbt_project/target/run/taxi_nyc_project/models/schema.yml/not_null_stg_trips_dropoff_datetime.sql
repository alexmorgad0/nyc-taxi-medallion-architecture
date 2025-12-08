
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_4c8d3f315598f1637f069cf3074df17a_6210]
   as 
    
    
    



select dropoff_datetime
from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
where dropoff_datetime is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_4c8d3f315598f1637f069cf3074df17a_6210]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_4c8d3f315598f1637f069cf3074df17a_6210]
  ;')