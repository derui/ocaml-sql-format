module F = Formatter
module P = Parser.Parser

let actual = {|
  drop index if exists abc
|}

let option = F.Options.default

let%test_unit "drop_index_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "drop_index_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| DROP INDEX IF EXISTS abc; |}]
