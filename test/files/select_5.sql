select * from a where a between (select 1) and (select * from b)
