select
 count(*) as v,
 count_big(*) as v1,
 count(v) as v14,
 count_big(a) as v15,
 sum(all e) as v2,
 avg(distinct e) as v3,
 avg(distinct e) as v4,
 min(e) as v5,
 max(e) as v6,
 every(e) as v7,
 stddev_pop(e) as v8,
 stddev_samp(e) as v9,
 var_samp(e) as v10,
 var_pop(e) as v11,
 some(b.e) as v12,
 any(e) as v13
from a, b
