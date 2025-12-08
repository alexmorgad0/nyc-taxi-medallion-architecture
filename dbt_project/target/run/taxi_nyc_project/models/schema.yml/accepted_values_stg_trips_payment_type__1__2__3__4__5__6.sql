
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_f33210bcd4b055fe9687c095053b88a1_9683]
   as 
    
    
    

with all_values as (

    select
        payment_type as value_field,
        count(*) as n_records

    from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
    group by payment_type

)

select *
from all_values
where value_field not in (
    ''1'',''2'',''3'',''4'',''5'',''6''
)



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_f33210bcd4b055fe9687c095053b88a1_9683]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_f33210bcd4b055fe9687c095053b88a1_9683]
  ;')