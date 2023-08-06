insert into a (a,b,c,d,e)
select 1,2,3,4,5 from v where a = 'c' and b like '%afb'
returning id, id2
