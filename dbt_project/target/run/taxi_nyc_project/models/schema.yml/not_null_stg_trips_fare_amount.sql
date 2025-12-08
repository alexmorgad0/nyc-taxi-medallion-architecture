
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_9ea19f17f3a1a85ec021164b6969d1d9_12050]
   as 
    
    
    



select fare_amount
from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
where fare_amount is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_9ea19f17f3a1a85ec021164b6969d1d9_12050]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_9ea19f17f3a1a85ec021164b6969d1d9_12050]
  ;')