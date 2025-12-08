
    
    

select
    trip_id as unique_field,
    count(*) as n_records

from "sqldb-taxi-platform"."bronze_silver"."fact_trips"
where trip_id is not null
group by trip_id
having count(*) > 1


