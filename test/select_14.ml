module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 very_looooooooooooooooooooooooooooooooooooong_identifier * very_loooooooooooooooooooooooooooooooooooooooooong / very_loooooooooooooooooooooooooooooooooong +  very_looooooooooooooooooooooooooooooooooooong_identifier * very_loooooooooooooooooooooooooooooooooooooooooong / very_loooooooooooooooooooooooooooooooooong

from a
|}

let option = F.Options.default

let%test_unit "select_14 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_14 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT
        very_looooooooooooooooooooooooooooooooooooong_identifier * very_loooooooooooooooooooooooooooooooooooooooooong / very_loooooooooooooooooooooooooooooooooong + very_looooooooooooooooooooooooooooooooooooong_identifier * very_loooooooooooooooooooooooooooooooooooooooooong / very_loooooooooooooooooooooooooooooooooong
    FROM
        a; |}]
