select
   sample()
  ,test(1,3, 'a')
  ,count(all 3)
  ,session(distinct order by e desc)
  ,session(distinct order by e desc) filter (where v > 50)
from a
