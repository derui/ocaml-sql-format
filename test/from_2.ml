module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT * from test_table abc, ident as "next",
               third
|}

let option = F.Options.default

let%test_unit "multiple tables in from for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_entry actual_ast expect_ast)

let%expect_test "multiple tables in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| SELECT *  FROM test_table AS abc,ident AS "next",third |}]
