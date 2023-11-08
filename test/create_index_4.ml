module F = Formatter
module P = Parser.Parser

let actual = {|
  create index if not exists about.a on foo (long_column_name)
|}

let option = F.Options.default

let%test_unit "create_index_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_index_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    CREATE INDEX IF NOT EXISTS about.a ON foo (
        long_column_name
    ); |}]
