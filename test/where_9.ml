module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT * from "table" b
where
    b is distinct from a
 OR b is not distinct from 'a'
|}

let option = F.Options.default

let%test_unit "where_9 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where_9 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          *
      FROM
          "table" AS b WHERE b IS DISTINCT FROM a OR b IS NOT DISTINCT FROM 'a' |}]
