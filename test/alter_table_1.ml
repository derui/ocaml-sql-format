module F = Formatter
module P = Parser.Parser

let actual = {|
  alter table a.b rename to "foo_bar"
|}

let option = F.Options.default

let%test_unit "alter_table_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "alter_table_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| ALTER TABLE a.b RENAME TO"foo_bar" |}]
