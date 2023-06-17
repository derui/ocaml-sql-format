module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT  * INTO "some_table name"
       union all select t.b from table t having b
       union distinct select 3
       except select d from e
       order by b
|}

let option = F.Options.default

let%test_unit "select into for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select into for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT * INTO "some_table name" UNION ALL
    SELECT t.b  FROM table AS t HAVING b UNION DISTINCT SELECT 3 EXCEPT
    SELECT d  FROM e
    ORDER BY b |}]
