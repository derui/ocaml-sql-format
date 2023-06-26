select
  substring(e from 3)
 ,substring(e from 3 for 5)
 ,substring(e, 3)
 ,substring(e, 3, 4)
 ,substring(e, 3, 4, 5)
from a
