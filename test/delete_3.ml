module F = Formatter
module P = Parser.Parser

let actual =
  {|
  with a as ( select a,b,c, 10 from a )
,b as (select all 50)
,c as (select distinct id from d)
delete from other_table where id >= 50
|}

let option = F.Options.default

let%test_unit "delete_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "delete_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    WITH a AS (
        SELECT
            a,
            b,
            c,
            10
        FROM
            a
    )
    ,
    b AS (
        SELECT ALL
            50
    )
    ,
    c AS (
        SELECT DISTINCT
            id
        FROM
            d
    )
    DELETE FROM other_table
    WHERE
        id >= 50; |}]
