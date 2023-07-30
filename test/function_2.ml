module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  cast(e as varchar)
 ,cast(e as boolean)
 ,cast(e as byte)
 ,cast(e as tinyint)
 ,cast(e as short)
 ,cast(e as smallint)
 ,cast(e as char(3)[])
 ,cast(e as integer)
 ,cast(e as long)
 ,cast(e as bigint)
 ,cast(e as biginteger)
 ,cast(e as float)
 ,cast(e as real)
 ,cast(e as double)
 ,cast(e as bigdecimal(1))
 ,cast(e as bigdecimal(1,3))
 ,cast(e as decimal(3,1))
 ,cast(e as date)
 ,cast(e as time)
 ,cast(e as timestamp)
 ,cast(e as object)
 ,cast(e as blob)
 ,cast(e as clob)
 ,cast(e as json)
 ,cast(e as varbinary)
 ,cast(e as geometry)
 ,cast(e as geography)
 ,cast(e as xml)
 ,cast(e as other_type)
 ,cast(e as other_type[])
from a
|}

let option = F.Options.default

let%test_unit "function_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {||}]
