with a as (
 select 1 from b
),
"abc" (e) as (select 2 from c)
select * from a, "abc"
