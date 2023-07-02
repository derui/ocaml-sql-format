module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
   sample()
  ,test(1,3, 'a')
  ,count(all 3)
  ,session(distinct order by e desc)
  ,session(distinct order by e desc) filter (where v > 50)
from a
|}

let option = F.Options.default

let%test_unit "function_13 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_13 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          sample(),
          test(1,3,'a'),
          COUNT(ALL 3),
          session(DISTINCT ORDER BY e DESC),
          session(DISTINCT ORDER BY e DESC) FILTER (WHERE v > 50)
      FROM
          a |}]
