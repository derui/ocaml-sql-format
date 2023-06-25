select
  row_number() over () as v,
  rank() over (partition by e) as v2,
  dense_rank() over (partition by e order by a desc) as v3,
  percent_rank() filter (where e < 1500) over (partition by e range unbounded following) as v4,
  cume_dist() over (partition by e rows 3 following) as v4
from a, b
