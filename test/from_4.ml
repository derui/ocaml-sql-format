module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select * from
  a
  cross join f
  union join g
  inner join b on a.id = b.id
  join b on a.id = b.id
  left outer join c on a.id = c.id
  full join d on a.id = d.id
|}

let option = F.Options.default

let%test_unit "from_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "from_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          *
       FROM a CROSS JOIN f UNION JOIN g INNER JOIN b ON a.id = b.id JOIN b ON a.id = b.id LEFT JOIN c ON a.id = c.id FULL JOIN d ON a.id = d.id |}]
