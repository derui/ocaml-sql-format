SELECT * from table b
where
    b in (select c * 151 from table_c)
 OR b in (1, 34, 'abc')
AND c not in (3, 4)
 AND b not in (select a,b,c,d,e, "f g" from table_d)
