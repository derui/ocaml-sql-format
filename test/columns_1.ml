module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT abc as a_b_c,b,c,d , e
|}

let option = F.Options.default

let%test_unit "column for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_statement actual_ast expect_ast)

let%expect_test "column for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| SELECT abc AS a_b_c,b,c,d,e |}]
