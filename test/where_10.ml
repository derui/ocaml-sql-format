module F = Formatter
module P = Parser.Parser

let actual =
  {|
  SELECT * from "table" b
where
    b exists (select 1 from a)
AND NOT b exists (select 3 from b)
|}

let option = F.Options.default

let%test_unit "where_10 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "where_10 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          *
      FROM
          "table" AS b
      WHERE
              b EXISTS (
                  SELECT
                      1
                  FROM
                      a
              )
          AND NOT b EXISTS (
                      SELECT
                          3
                      FROM
                          b
                  ) |}]
