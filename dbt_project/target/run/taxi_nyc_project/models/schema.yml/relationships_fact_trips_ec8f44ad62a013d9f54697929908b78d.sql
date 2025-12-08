
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_fe69b692e4963f1fa2cf4dd07e39b696_16864]
   as 
    
    
    

with child as (
    select payment_type as from_field
    from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
    where payment_type is not null
),

parent as (
    select payment_type as to_field
    from "sqldb-taxi-platform"."bronze_silver"."dim_payment_type"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [bronze].[testview_fe69b692e4963f1fa2cf4dd07e39b696_16864]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_fe69b692e4963f1fa2cf4dd07e39b696_16864]
  ;')