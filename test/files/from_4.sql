select * from
  a
  cross join f
  union join g
  inner join b on a.id = b.id
  join b on a.id = b.id
  left outer join c on a.id = c.id
  full join d on a.id = d.id
