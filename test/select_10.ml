module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  count(*) over () as v,
  count(*) over (partition by expr order by bc) as v3,
  count(*) filter (where a = 3) as v4,
  count(*) filter (where b > 4) over (range current row) as v5,
  count(*) over (range unbounded preceding) as v6,
  count(*) over (range 3 preceding) as v7,
  count(*) over (range between unbounded preceding and unbounded following) as v8,
  count(*) over (rows unbounded preceding) as v9,
  count(*) over (rows 3 preceding) as v10,
  count(*) over (rows between unbounded preceding and unbounded following) as v11
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
          COUNT(*) OVER (

          ) AS v,
          COUNT(*) OVER (

              PARTITION BY expr
              ORDER BY
                  bc

          ) AS v3,
          COUNT(*) FILTER (WHERE a = 3) AS v4,
          COUNT(*) FILTER (WHERE b > 4) OVER (

              RANGE CURRENT ROW
          ) AS v5,
          COUNT(*) OVER (

              RANGE UNBOUNDED PRECEDING
          ) AS v6,
          COUNT(*) OVER (

              RANGE 3 PRECEDING
          ) AS v7,
          COUNT(*) OVER (

              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
          ) AS v8,
          COUNT(*) OVER (

              ROWS UNBOUNDED PRECEDING
          ) AS v9,
          COUNT(*) OVER (

              ROWS 3 PRECEDING
          ) AS v10,
          COUNT(*) OVER (

              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
          ) AS v11

      FROM
          a,
          b |}]
