module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
   position('a' in 'abcdef')
  ,position('abcdefd' in 5)
  ,position('abcdefd' in c.de)
from a
|}

let option = F.Options.default

let%test_unit "function_10 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_10 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          POSITION('a' IN 'abcdef'),
          POSITION('abcdefd' IN 5),
          POSITION('abcdefd' IN c.de)
      FROM
          a |}]
