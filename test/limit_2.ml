module F = Formatter
module P = Parser.Parser

let actual = {|
   SELECT a, b from test_table limit 5, 9
   |}

let option = F.Options.default

let%test_unit "limit in from for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "limit in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
      SELECT
          a,
          b
      FROM
          test_table; |}]
