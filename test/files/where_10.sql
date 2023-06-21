SELECT * from table b
where
    b exists (select 1 from a)
AND NOT b exists (select 3 from b)
