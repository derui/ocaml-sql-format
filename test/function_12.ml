module F = Formatter
module P = Parser.Parser

let actual = {|
  select
  current_date()
from a
|}

let option = F.Options.default

let%test_unit "function_12 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_12 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    SELECT
        CURRENT_DATE()
    FROM
        a; |}]
