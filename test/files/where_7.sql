SELECT * from table b
where
    b <= all (select c * 151 from table_c)
 OR b >= some (select c * 151 from table_c)
 AND b < any (select c * 151 from table_c)
