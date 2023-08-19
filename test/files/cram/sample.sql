select a,b,c,d,e,long,a.long_foo from a inner join c on c.id = a.c_id
group by a,b
having c = 3
order by a,b,c
