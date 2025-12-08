
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_83c247fd7dcf1f459750c2de25501c63_14888]
   as 
    
    
    



select total_amount
from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
where total_amount is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_83c247fd7dcf1f459750c2de25501c63_14888]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_83c247fd7dcf1f459750c2de25501c63_14888]
  ;')