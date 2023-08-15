module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT * from test_table
|}

let option = F.Options.default

let%test_unit "simplest sql for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "simplest sql for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    SELECT
        *
    FROM
        test_table; |}]
