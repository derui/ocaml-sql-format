module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  trim('abc')
  ,trim(leading from 'abc')
  ,trim(trailing from 'abc')
  ,trim(both from 'abc')
  ,trim(leading 'a' from 'abc')
  ,trim(trailing ' ' from 'abc')
  ,trim(both e from 'abc')
  ,trim('a' from 'abc')
from a
|}

let option = F.Options.default

let%test_unit "funciton_5 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "funciton_5 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          TRIM('abc'),TRIM(LEADING FROM 'abc'),TRIM(TRAILING FROM 'abc'),TRIM(BOTH FROM 'abc'),TRIM(LEADING 'a' FROM 'abc'),TRIM(TRAILING ' ' FROM 'abc'),TRIM(BOTH e FROM 'abc'),TRIM('a' FROM 'abc')
      FROM
          a |}]
