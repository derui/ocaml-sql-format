module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create unique index if not exists foo.a on foo (a,b,c)
where a > 15
|}

let option = F.Options.default

let%test_unit "create_index_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_index_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE UNIQUE INDEX IF NOT EXISTS foo.a ON foo (
        a,
        b,
        c
    ) WHERE
        a > 15; |}]
