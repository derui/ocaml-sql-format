with a as (
 select 1 from b
),
"abc" (e) as (select 2 from c),
multi_column (e, b, f) as (select 3 from d)
select * from a, "abc"
