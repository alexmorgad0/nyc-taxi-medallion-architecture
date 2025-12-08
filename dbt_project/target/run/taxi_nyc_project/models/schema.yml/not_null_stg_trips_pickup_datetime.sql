
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_c8f1217ea7ae423f95431cf67128255c_14902]
   as 
    
    
    



select pickup_datetime
from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
where pickup_datetime is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_c8f1217ea7ae423f95431cf67128255c_14902]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_c8f1217ea7ae423f95431cf67128255c_14902]
  ;')