module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select * from
  a cross join (b as "t" left join c on a.id = b.id)
|}

let option = F.Options.default

let%test_unit "from_5 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "from_5 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          *

      FROM
          a
          CROSS JOIN (
              b AS "t"
              LEFT OUTER JOIN c
                  ON a.id = b.id

          ) |}]
