module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  row_number() over () as v,
  rank() over (partition by e) as v2,
  dense_rank() over (partition by e order by a desc) as v3,
  percent_rank() filter (where e < 1500) over (partition by e range unbounded following) as v4,
  cume_dist() over (partition by e rows 3 following) as v4
from a, b
|}

let option = F.Options.default

let%test_unit "select_11 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_11 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          ROW_NUMBER() OVER () AS v,RANK() OVER (PARTITION BY e) AS v2,DENSE_RANK() OVER (PARTITION BY e ORDER BY a DESC) AS v3,PERCENT_RANK() FILTER (WHERE e < 1500) OVER (PARTITION BY e RANGE UNBOUNDED FOLLOWING) AS v4,CUME_DIST() OVER (PARTITION BY e ROWS 3 FOLLOWING) AS v4
       FROM a,b |}]
