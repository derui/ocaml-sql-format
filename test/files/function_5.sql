select
   trim(leading from 'abc')
  ,trim(trailing from 'abc')
  ,trim(both from 'abc')
  ,trim(leading 'a' from 'abc')
  ,trim(trailing ' ' from 'abc')
  ,trim(both e from 'abc')
  ,trim('a' from 'abc')
from a
