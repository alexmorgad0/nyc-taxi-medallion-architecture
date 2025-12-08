

with numbers as (
    -- generate 365 rows: 0..364
    select top (365)
        row_number() over(order by (select null)) - 1 as n
    from sys.objects
),
dates as (
    select
        dateadd(day, n, cast('2025-01-01' as date)) as date_actual
    from numbers
)

select
    date_actual                           as date_key,   -- PK
    date_actual                           as date_actual,
    year(date_actual)                     as year,
    month(date_actual)                    as month,
    datename(month, date_actual)          as month_name,
    day(date_actual)                      as day,
    datename(weekday, date_actual)        as weekday_name,
    datepart(weekday, date_actual)        as weekday_num,
    case when datepart(weekday, date_actual) in (1, 7)
         then 1 else 0 end                as is_weekend
from dates;