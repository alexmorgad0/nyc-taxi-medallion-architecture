
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_20905412c48dcf3bfd76540d3b87984e_14702]
   as 
    
    
    



select trip_id
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
where trip_id is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_20905412c48dcf3bfd76540d3b87984e_14702]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_20905412c48dcf3bfd76540d3b87984e_14702]
  ;')