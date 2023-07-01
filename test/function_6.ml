module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
   to_chars(abc, 'c')
  ,to_chars(abc, 'c', 123)
  ,to_bytes(abc, 'c')
  ,to_bytes(abc, 'c', 123)
from a
|}

let option = F.Options.default

let%test_unit "function_6 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_6 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          TO_CHARS(abc,'c'),TO_CHARS(abc,'c', 123),TO_BYTES(abc,'c'),TO_BYTES(abc,'c', 123)
      FROM a |}]
