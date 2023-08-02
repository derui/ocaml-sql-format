module F = Formatter
module P = Parser.Parser

let actual =
  {|
   SELECT a, b from test_table where b like '%abad'
   or d like 'abc%'
   or e not like 'abc%'
   or c like 'abc%' escape 'f'
   |}

let option = F.Options.default

let%test_unit "where with between in from for AST" =
  let actual_ast = F.from_string actual ~option
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where with between in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          a,
          b
      FROM
          test_table

      WHERE
          b LIKE '%abad' OR d LIKE 'abc%' OR e NOT LIKE 'abc%' OR c LIKE 'abc%' ESCAPE 'f' |}]
