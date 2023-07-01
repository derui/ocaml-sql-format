module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT * from "table" b
where
    b in (select c * 151 from table_c)
 OR b in (1, 34, 'abc')
AND c not in (3, 4)
 AND b not in (select a,b,c,d,e, "f g" from table_d)
|}

let option = F.Options.default

let%test_unit "where_8 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where_8 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          *
      FROM
          "table" AS b
      WHERE
          b IN (

              SELECT
                  c * 151
              FROM
                  table_c
          ) OR b IN (1, 34, 'abc') AND c NOT IN (3, 4) AND b NOT IN (

              SELECT
                  a,b,c,d,e,"f g"
              FROM
                  table_d
          ) |}]
