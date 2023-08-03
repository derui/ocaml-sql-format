module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 very_looooooooooooooooooooooooooooooooooooong_identifier * very_loooooooooooooooooooooooooooooooooooooooooong / very_loooooooooooooooooooooooooooooooooong
from a
|}

let option = { F.Options.default with max_line_length = 500 }

let%test_unit "select_15 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_15 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT
        very_looooooooooooooooooooooooooooooooooooong_identifier * very_loooooooooooooooooooooooooooooooooooooooooong / very_loooooooooooooooooooooooooooooooooong
    FROM
        a |}]
