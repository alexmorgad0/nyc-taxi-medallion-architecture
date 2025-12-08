
    -- Create target schema if it does not
  USE [sqldb-taxi-platform];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
  BEGIN
    EXEC('CREATE SCHEMA [bronze]')
  END

  

  
  EXEC('create view 
    [bronze].[testview_b629aa227657300b15c0f9be86057eab_16672]
   as 
    
    
    

with child as (
    select pickup_date as from_field
    from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
    where pickup_date is not null
),

parent as (
    select date_key as to_field
    from "sqldb-taxi-platform"."bronze_silver"."dim_date"
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
    [bronze].[testview_b629aa227657300b15c0f9be86057eab_16672]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [bronze].[testview_b629aa227657300b15c0f9be86057eab_16672]
  ;')