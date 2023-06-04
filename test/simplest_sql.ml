module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT *
|}

let option = ()

let%test_unit "simplest sql for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_statement actual_ast expect_ast)

let%expect_test "simplest sql for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| SELECT * |}]
