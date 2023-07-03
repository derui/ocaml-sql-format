module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT * from "table" b
where
    b <= all (select c * 151 from table_c)
 OR b >= some (select c * 151 from table_c)
 AND b < any (select c * 151 from table_c)
|}

let option = F.Options.default

let%test_unit "where_7 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where_7 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          *
      FROM
          "table" AS b
      WHERE
          b <= ALL (
              SELECT
                  c * 151
              FROM
                  table_c
          )
          OR  b >= SOME (
                  SELECT
                      c * 151
                  FROM
                      table_c
              )
          AND b < ANY (
                  SELECT
                      c * 151
                  FROM
                      table_c
              ) |}]
