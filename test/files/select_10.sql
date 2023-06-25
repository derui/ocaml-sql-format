select
  count(*) over () as v,
  textagg (for a as t1, b as t2 delimiter ',') over (partition by e) as v2,
  count(*) over (partition by expr order by bc) as v3,
  count(*) filter (where a = 3) as v4,
  count(*) filter (where b > 4) over (range current row) as v5,
  count(*) over (range unbounded following) as v6,
  count(*) over (range 3 preceding) as v7,
  count(*) over (range between unbounded following and unbounded preceding) as v8,
  count(*) over (rows unbounded following) as v9,
  count(*) over (rows 3 preceding) as v10,
  count(*) over (rows between unbounded following and unbounded preceding) as v11
from a, b
