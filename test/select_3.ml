module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT  * INTO "some_table name" union select t.b from table t
|}

let option = F.Options.default

let%test_unit "select into for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_entry actual_ast expect_ast)

let%expect_test "select into for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT * INTO "some_table name" UNION
    SELECT t.b  FROM table AS t |}]
