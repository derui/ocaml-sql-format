module F = Formatter
module P = Parser.Parser

let actual = {|
  select
   left()
  ,left('a', '2')
  ,right()
  ,right('a', '2')
from a
|}

let option = F.Options.default

let%test_unit "function_8 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_8 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT
        LEFT(),
        LEFT('a', '2'),
        RIGHT(),
        RIGHT('a', '2')
    FROM
        a; |}]
