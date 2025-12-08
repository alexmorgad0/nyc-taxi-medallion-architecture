
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_4dded7e06fdf8cf96858af6f2dabdb0d_2488]
   as 
    
    
    

with all_values as (

    select
        rate_code_id as value_field,
        count(*) as n_records

    from "sqldb-taxi-platform"."bronze_bronze"."stg_trips"
    group by rate_code_id

)

select *
from all_values
where value_field not in (
    ''1'',''2'',''3'',''4'',''5'',''99''
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
    [bronze].[testview_4dded7e06fdf8cf96858af6f2dabdb0d_2488]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_4dded7e06fdf8cf96858af6f2dabdb0d_2488]
  ;')