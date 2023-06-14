module F = Formatter
module P = Parser.Parser

let actual = {|
   SELECT a, b from test_table offset 8 row
   |}

let option = F.Options.default

let%test_unit "limit in from for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_entry actual_ast expect_ast)

let%expect_test "limit in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
      SELECT a,b  FROM test_table
      OFFSET 8 ROW |}]