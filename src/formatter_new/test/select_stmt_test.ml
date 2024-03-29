module O = Formatter_new.Options

let options = { O.default with keyword_case = `upper }

let%expect_test "simple select" =
  Util.run ~options "select 1";
  [%expect {|
    SELECT
        1 |}];

  Util.run ~options "select *";
  [%expect {|
    SELECT
        * |}];

  Util.run ~options "select a from abc";
  [%expect {|
    SELECT
        a
    FROM
        abc |}];

  Util.run ~options {|select a from "long table name"|};
  [%expect {|
    SELECT
        a
    FROM
        "long table name" |}]

let%expect_test "union" =
  Util.run ~options {|
  SELECT  * from "some_table name" union select t.b from "table" t
|};
  [%expect
    {|
    SELECT
        *
    FROM
        "some_table name"
    UNION
    SELECT
        t.b
    FROM
        "table"t |}]

let%expect_test "with clause" =
  Util.run ~options
    {|
with a as (select 1 from b),
"abc" (e) as (select 2 from c),
foo (e, b, f) as (select 3 from d)
select * from a, "abc", foo
                     |};
  [%expect
    {|
    WITH a AS (
        SELECT
            1
        FROM
            b
    )
    ,
    "abc" (
        e
    ) AS (
        SELECT
            2
        FROM
            c
    )
    ,
    foo (
        e,b,f
    ) AS (
        SELECT
            3
        FROM
            d
    )SELECT
         *
     FROM
         a, "abc", foo |}];

  Util.run ~options {|
with recursive a as (select 1 from b)
select a.* from a
                     |};
  [%expect
    {|
    WITH RECURSIVE a AS (
        SELECT
            1
        FROM
            b
    )SELECT
         a.*
     FROM
         a |}]

let%expect_test "where" =
  Util.run ~options {|  select * from a where a between 1 and b |};
  [%expect {|
    SELECT
        *
    FROM
        a
    WHERE
        a BETWEEN 1 AND b |}]

let%expect_test "case" =
  Util.run ~options
    {|
  select
 case a * 10
   when 15 then 11
   when c then 12
   else 13
 end as v,
  case a * 10
  when 5 then 1
 end as v

from a
                     |};

  [%expect
    {|
    SELECT
        CASE a * 10
        WHEN 15 THEN 11
        WHEN c THEN 12
        ELSE 13
        END AS v,
        CASE a * 10
        WHEN 5 THEN 1
        END AS v
    FROM
        a |}]

let%expect_test "result columns" =
  Util.run ~options
    {| select
 count() as v,
 count(v) as v14,
 sum(e) as v2,
 avg(distinct e) as v3,
 avg(distinct e) as v4,
 min(e) as v5,
 max(e) as v6,
 every(e) as v7,
 some(b.e) as v12,
 any(e) as v13
from a, b;
                     |};

  [%expect
    {|
    SELECT
        COUNT() AS v,
        COUNT() AS v14,
        SUM() AS v2,
        AVG(distinct ) AS v3,
        AVG(distinct ) AS v4,
        MIN() AS v5,
        MAX() AS v6,
        EVERY() AS v7,
        SOME() AS v12,
        ANY() AS v13
    FROM
        a, b
    ; |}]
