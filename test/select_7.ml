module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 case
 when 15 = 15 then 11
 when c > 1 then 12
 else 13
 end as v,
 case e
 when a then 3
 end as e
from a
|}

let option = F.Options.default

let%test_unit "select_7 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_7 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          CASE WHEN 15 = 15 THEN 11 WHEN c > 1 THEN 12 ELSE 13 END AS v,CASE e WHEN a THEN 3 END AS e
      FROM
          a |}]
