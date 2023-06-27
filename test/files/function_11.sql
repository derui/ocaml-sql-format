select
   listagg('abc') within group (order by a, b desc)
  ,listagg("array", 'foo') within group (order by a asc)
from a
