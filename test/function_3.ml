module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  substring(e from 3)
 ,substring(e from 3 for 5)
 ,substring(e, 3)
 ,substring(e, 3, 4)
 ,substring(e, 3, 4, 5)
from a
|}

let option = F.Options.default

let%test_unit "funciton_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "funciton_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          SUBSTRING(e FROM 3),SUBSTRING(e FROM 3 FOR 5),SUBSTRING(e, 3),SUBSTRING(e, 3, 4),SUBSTRING(e, 3, 4, 5)
      FROM
          a |}]
