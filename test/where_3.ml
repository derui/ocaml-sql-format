module F = Formatter
module P = Parser.Parser

let actual =
  {|
   SELECT a, b from test_table where b between 50 and 60 or b not between 1 and 5
   |}

let option = F.Options.default

let%test_unit "where with between in from for AST" =
  let actual_ast = F.from_string ~option actual
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
          b BETWEEN 50 AND 60 OR b NOT BETWEEN 1 AND 5 |}]
