select
  textagg (for a as t1, b as t2 delimiter ',' quote 'a' header encoding "euc-jp") as v,
  textagg (for a as t1, b as t2 delimiter ',' no quote order by t2) as v2,
  textagg (for a as t1, b as t2 delimiter ',') as v3
from a
