
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_7d112b4bacf9180b503a254961208261_17112]
   as 
    
    
    



select pickup_date
from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
where pickup_date is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_7d112b4bacf9180b503a254961208261_17112]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_7d112b4bacf9180b503a254961208261_17112]
  ;')