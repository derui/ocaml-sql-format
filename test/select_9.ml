module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 count(*) as v,
 count_big(*) as v1,
 count(v) as v14,
 count_big(a) as v15,
 sum(all e) as v2,
 avg(distinct e) as v3,
 avg(distinct e) as v4,
 min(e) as v5,
 max(e) as v6,
 every(e) as v7,
 stddev_pop(e) as v8,
 stddev_samp(e) as v9,
 var_samp(e) as v10,
 var_pop(e) as v11,
 some(b.e) as v12,
 any(e) as v13
from a, b
|}

let option = F.Options.default

let%test_unit "select_9 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_9 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          COUNT(*) AS v,COUNT_BIG(*) AS v1,COUNT(v) AS v14,COUNT_BIG(a) AS v15,SUM(ALL e) AS v2,AVG(DISTINCT e) AS v3,AVG(DISTINCT e) AS v4,MIN(e) AS v5,MAX(e) AS v6,EVERY(e) AS v7,STDDEV_POP(e) AS v8,STDDEV_SAMP(e) AS v9,VAR_SAMP(e) AS v10,VAR_POP(e) AS v11,SOME(b.e) AS v12,ANY(e) AS v13
      FROM a,b |}]
