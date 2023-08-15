module F = Formatter
module P = Parser.Parser

let actual = {|
  create view a as select a, b, c from foo, bar
|}

let option = F.Options.default

let%test_unit "create_view_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_view_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE VIEW a AS
        SELECT
            a,
            b,
            c
        FROM
            foo,
            bar |}]
