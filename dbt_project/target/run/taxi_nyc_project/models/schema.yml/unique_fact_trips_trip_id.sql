
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_2a9748c0e241ec04f816d7766bd33ba6_15550]
   as 
    
    
    

select
    trip_id as unique_field,
    count(*) as n_records

from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
where trip_id is not null
group by trip_id
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
    [bronze].[testview_2a9748c0e241ec04f816d7766bd33ba6_15550]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_2a9748c0e241ec04f816d7766bd33ba6_15550]
  ;')