select
   to_chars(abc, 'c')
  ,to_chars(abc, 'c', 123)
  ,to_bytes(abc, 'c')
  ,to_bytes(abc, 'c', 123)
from a
