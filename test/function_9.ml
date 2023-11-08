module F = Formatter
module P = Parser.Parser

let actual = {|
  select
   translate()
  ,translate('a', '2')
from a
|}

let option = F.Options.default

let%test_unit "function_9 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_9 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    SELECT
        TRANSLATE(),
        TRANSLATE('a', '2')
    FROM
        a; |}]
