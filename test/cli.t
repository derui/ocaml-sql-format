Format with default format options
  $ ../../install/default/bin/ocaml-sql-format files/cram/sample.sql
  
  SELECT
      a,
      b,
      c,
      d,
      e,
      long,
      a.long_foo
  FROM
      a
      INNER JOIN c
          ON c.id = a.c_id
  GROUP BY
      a,
      b
  HAVING
      c = 3;
  
  


Format with config file
  $ ../../install/default/bin/ocaml-sql-format -c files/cram/lower.toml files/cram/sample.sql
  
  select
      a,
      b,
      c,
      d,
      e,
      long,
      a.long_foo
  from
      a
      inner join c
          on c.id = a.c_id
  group by
      a,
      b
  having
      c = 3;
  
  
Format with config file that changes indent size
  $ ../../install/default/bin/ocaml-sql-format -c files/cram/indent.toml files/cram/sample.sql
  
  SELECT
    a,
    b,
    c,
    d,
    e,
    long,
    a.long_foo
  FROM
    a
    INNER JOIN c
      ON c.id = a.c_id
  GROUP BY
    a,
    b
  HAVING
    c = 3;
  
  
