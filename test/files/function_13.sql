select
   sample()
  ,test(1,3, 'a')
  ,count(3)
  ,session(distinct e) filter (where v > 50)
from a
