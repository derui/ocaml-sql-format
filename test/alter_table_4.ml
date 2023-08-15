module F = Formatter
module P = Parser.Parser

let actual = {|
  alter table a.b add column new_col varchar(50) not null
|}

let option = F.Options.default

let%test_unit "alter_table_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "alter_table_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| ALTER TABLE a.b ADD COLUMN new_col varchar(50) NOT NULL; |}]
