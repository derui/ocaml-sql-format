select * from
  a cross join (b as "t" left join c on a.id = b.id)
