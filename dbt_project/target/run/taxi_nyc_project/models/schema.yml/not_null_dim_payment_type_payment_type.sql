
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_2ad2dc6a1d72454bc6f07cc7701e665e_9142]
   as 
    
    
    



select payment_type
from "sqldb-taxi-platform"."bronze_silver"."dim_payment_type"
where payment_type is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_2ad2dc6a1d72454bc6f07cc7701e665e_9142]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_2ad2dc6a1d72454bc6f07cc7701e665e_9142]
  ;')