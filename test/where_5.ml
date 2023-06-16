module F = Formatter
module P = Parser.Parser

let actual =
  {|
   SELECT a, b from test_table where b like '%abad'
   or c not like 'abc%'
   or d similar to 'abc%'
   or e not similar to 'abc%'
   or c similar to 'abc%' escape 'f'
   or c similar to 'abc%' { escape 'f' }
   |}

let option = F.Options.default

let%test_unit "where with between in from for AST" =
  let actual_ast = Util.parse actual
  and expect_ast = Util.parse @@ F.from_string actual ~option in
  assert (List.for_all2 Parser.Ast.equal_entry actual_ast expect_ast)

let%expect_test "where with between in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {| SELECT a,b  FROM test_table WHERE b LIKE '%abad' OR c NOT LIKE 'abc%' OR d SIMILAR TO 'abc%' OR e NOT SIMILAR TO 'abc%' OR c SIMILAR TO 'abc%' ESCAPE 'f' OR c SIMILAR TO 'abc%' ESCAPE 'f' |}]
