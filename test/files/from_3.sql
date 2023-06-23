select * from a, table (select a,b,c from e) t, lateral (select c,d,f from e) as v_v
,(select abc from f) as e
