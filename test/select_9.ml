module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 count(*) as v,
 count(v) as v14,
 sum(e) as v2,
 avg(distinct e) as v3,
 avg(distinct e) as v4,
 min(e) as v5,
 max(e) as v6,
 every(e) as v7,
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
          COUNT(*) AS v,
          COUNT(v) AS v14,
          SUM(e) AS v2,
          AVG(DISTINCT e) AS v3,
          AVG(DISTINCT e) AS v4,
          MIN(e) AS v5,
          MAX(e) AS v6,
          EVERY(e) AS v7,
          SOME(b.e) AS v12,
          ANY(e) AS v13

      FROM
          a,
          b |}]
