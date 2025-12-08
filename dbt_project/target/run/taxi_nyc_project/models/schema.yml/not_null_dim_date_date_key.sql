
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_97a1514f1de409d55b5193a479b57439_15908]
   as 
    
    
    



select date_key
from "sqldb-taxi-platform"."bronze_silver"."dim_date"
where date_key is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_97a1514f1de409d55b5193a479b57439_15908]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_97a1514f1de409d55b5193a479b57439_15908]
  ;')