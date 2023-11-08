module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT * from "table"
where ((b > 1 AND b > 3) OR (c > 3 AND c < 500)) AND d > 3
|}

let option = F.Options.default

let%test_unit "where_11 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where_11 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT
        *
    FROM
        "table"
    WHERE
        b > 1 AND b > 3 OR c > 3 AND c < 500 AND d > 3; |}]
