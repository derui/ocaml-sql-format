with a as (
  select 1
) search depth first by a
,b as (
select a, b from table_c
) search breadth first by b asc
,c as (
select abc, "path" from table_d
) cycle abc set abc to 3 default 1 using "path"
,d as (
select b, abc, "path" from table_d
) search breadth first by b asc cycle abc set abc to 3 default 1 using "path"
select
  *
from a
