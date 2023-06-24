module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 case a * 10
 when 15 then 11
 when c then 12
 else 13
 end as v
from a
|}

let option = F.Options.default

let%test_unit "select_6 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_6 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {| SELECT CASE a * 10 WHEN 15 THEN 11 WHEN c THEN 12 ELSE 13 END AS v  FROM a |}]
