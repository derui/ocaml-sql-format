module F = Formatter
module P = Parser.Parser

let actual = {|
   SELECT a, b from test_table GROUP BY a having b
   |}

let option = F.Options.default

let%test_unit "having in from for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_entry actual_ast expect_ast)

let%expect_test "having in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| SELECT a,b  FROM test_table GROUP BY a HAVING b |}]
