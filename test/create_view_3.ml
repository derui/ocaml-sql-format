module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create temporary view if not exists a (c, "foobar", long_long) as select a, b, c from foo inner join bar on a = c
cross join test
|}

let option = F.Options.default

let%test_unit "create_view_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_view_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TEMPORARY VIEW IF NOT EXISTS a (
        c, "foobar", long_long
    ) AS
        SELECT
            a,
            b,
            c
        FROM
            foo
            INNER JOIN bar
                ON a = c
            CROSS JOIN test |}]
