
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_98902cdd2f59126a71dede1190f25913_2173]
   as 
    
    
    



select trip_distance
from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
where trip_distance is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_98902cdd2f59126a71dede1190f25913_2173]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_98902cdd2f59126a71dede1190f25913_2173]
  ;')