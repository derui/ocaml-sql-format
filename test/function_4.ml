module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  extract(year from 'abc')
  ,extract(month from 'abc')
  ,extract(day from 'abc')
  ,extract(hour from 'abc')
  ,extract(minute from 'abc')
  ,extract(second from 'abc')
  ,extract(quarter from 'abc')
  ,extract(epoch from 'abc')
  ,extract(dow from 'abc')
  ,extract(doy from 'abc')
from a
|}

let option = F.Options.default

let%test_unit "funciton_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "funciton_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          EXTRACT(YEAR FROM 'abc'),
          EXTRACT(MONTH FROM 'abc'),
          EXTRACT(DAY FROM 'abc'),
          EXTRACT(HOUR FROM 'abc'),
          EXTRACT(MINUTE FROM 'abc'),
          EXTRACT(SECOND FROM 'abc'),
          EXTRACT(QUARTER FROM 'abc'),
          EXTRACT(EPOCH FROM 'abc'),
          EXTRACT(DOW FROM 'abc'),
          EXTRACT(DOY FROM 'abc')
      FROM
          a |}]
