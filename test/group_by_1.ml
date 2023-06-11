module F = Formatter
module P = Parser.Parser

let actual =
  {|
   SELECT a, b from test_table GROUP BY test_table.a, test_table.b
   |}

let option = F.Options.default

let%test_unit "group by in from for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_entry actual_ast expect_ast)

let%expect_test "group by in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| SELECT a,b  FROM test_table GROUP BY test_table.a,test_table.b |}]