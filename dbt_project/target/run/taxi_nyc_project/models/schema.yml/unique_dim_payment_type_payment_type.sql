
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_5fb5eb828135bf31fab7f64ef24093d1_10134]
   as 
    
    
    

select
    payment_type as unique_field,
    count(*) as n_records

from "sqldb-taxi-platform"."bronze_silver"."dim_payment_type"
where payment_type is not null
group by payment_type
having count(*) > 1



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_5fb5eb828135bf31fab7f64ef24093d1_10134]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_5fb5eb828135bf31fab7f64ef24093d1_10134]
  ;')