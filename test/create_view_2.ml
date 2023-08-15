module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create temp view a (c, "foobar", long_long) as select a, b, c from foo, bar
|}

let option = F.Options.default

let%test_unit "create_view_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_view_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TEMPORARY VIEW a (
        c, "foobar", long_long
    ) AS
        SELECT
            a,
            b,
            c
        FROM
            foo,
            bar |}]
