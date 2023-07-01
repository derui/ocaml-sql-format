module F = Formatter
module P = Parser.Parser

let actual =
  {|
   SELECT a, b from test_table where b = 3 and c >= 5 AND NOT d != 5 OR e < 'far' OR f <= 5 AND g <> 510
   |}

let option = F.Options.default

let%test_unit "where with and/or in from for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where with and/or in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          a,b
      FROM
          test_table WHERE b = 3 AND c >= 5 AND NOT d != 5 OR e < 'far' OR f <= 5 AND g <> 510 |}]
