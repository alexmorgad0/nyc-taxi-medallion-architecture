
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_a400e2b5a883a058e35f384156d65f3b_10322]
   as 
    
    
    

select
    date_key as unique_field,
    count(*) as n_records

from "sqldb-taxi-platform"."bronze_silver"."dim_date"
where date_key is not null
group by date_key
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
    [bronze].[testview_a400e2b5a883a058e35f384156d65f3b_10322]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_a400e2b5a883a058e35f384156d65f3b_10322]
  ;')