module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  count(*) over () as v,
  textagg (for a as t1, b as t2 delimiter ',') over (partition by e) as v2,
  count(*) over (partition by expr order by bc) as v3,
  count(*) filter (where a = 3) as v4,
  count(*) filter (where b > 4) over (range current row) as v5,
  count(*) over (range unbounded following) as v6,
  count(*) over (range 3 preceding) as v7,
  count(*) over (range between unbounded following and unbounded preceding) as v8,
  count(*) over (rows unbounded following) as v9,
  count(*) over (rows 3 preceding) as v10,
  count(*) over (rows between unbounded following and unbounded preceding) as v11
from a, b
|}

let option = F.Options.default

let%test_unit "select_10 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_10 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          COUNT(*) OVER () AS v,TEXTAGG ( FOR a AS t1, b AS t2 DELIMITER ',') OVER (PARTITION BY e) AS v2,COUNT(*) OVER (PARTITION BY expr ORDER BY bc) AS v3,COUNT(*) FILTER (WHERE a = 3) AS v4,COUNT(*) FILTER (WHERE b > 4) OVER ( RANGE CURRENT ROW) AS v5,COUNT(*) OVER ( RANGE UNBOUNDED FOLLOWING) AS v6,COUNT(*) OVER ( RANGE 3 PRECEDING) AS v7,COUNT(*) OVER ( RANGE BETWEEN UNBOUNDED FOLLOWING AND UNBOUNDED PRECEDING) AS v8,COUNT(*) OVER ( ROWS UNBOUNDED FOLLOWING) AS v9,COUNT(*) OVER ( ROWS 3 PRECEDING) AS v10,COUNT(*) OVER ( ROWS BETWEEN UNBOUNDED FOLLOWING AND UNBOUNDED PRECEDING) AS v11
       FROM a,b |}]
