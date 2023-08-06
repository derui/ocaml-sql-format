with c as (
  select * from b
), d as (
   select id from c
)
update sche.tbl set a = 3, b = 4 from c inner join d on d.id = c.id where c >= 10
returning b.id
