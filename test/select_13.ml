module F = Formatter
module P = Parser.Parser

let actual = {|
  select  * into cd from a, b
|}

let option = F.Options.default

let%test_unit "select_13 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_13 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    SELECT
        *
    INTO cd
    FROM a,b |}]
