create temporary view if not exists a (c, "foobar", long_long) as select a, b, c from foo inner join bar on a = c
cross join test
