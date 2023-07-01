module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  convert(e, string)
 ,convert(e, string[])
 ,convert(e, varchar)
 ,convert(e, boolean)
 ,convert(e, byte)
 ,convert(e, tinyint)
 ,convert(e, short)
 ,convert(e, smallint)
 ,convert(e, char(3)[])
 ,convert(e, integer)
 ,convert(e, long)
 ,convert(e, bigint)
 ,convert(e, biginteger)
 ,convert(e, float)
 ,convert(e, real)
 ,convert(e, double)
 ,convert(e, bigdecimal(1))
 ,convert(e, bigdecimal(1,3))
 ,convert(e, decimal(3,1))
 ,convert(e, date)
 ,convert(e, time)
 ,convert(e, timestamp)
 ,convert(e, object)
 ,convert(e, blob)
 ,convert(e, clob)
 ,convert(e, json)
 ,convert(e, varbinary)
 ,convert(e, geometry)
 ,convert(e, geography)
 ,convert(e, xml)
 ,convert(e, other_type)
 ,convert(e, other_type[])
from a
|}

let option = F.Options.default

let%test_unit "funciton_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "funciton_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          CONVERT(e, STRING),CONVERT(e, STRING[]),CONVERT(e, VARCHAR),CONVERT(e, BOOLEAN),CONVERT(e, BYTE),CONVERT(e, TINYINT),CONVERT(e, SHORT),CONVERT(e, SMALLINT),CONVERT(e, CHAR(3)[]),CONVERT(e, INTEGER),CONVERT(e, LONG),CONVERT(e, BIGINT),CONVERT(e, BIGINTEGER),CONVERT(e, FLOAT),CONVERT(e, REAL),CONVERT(e, DOUBLE),CONVERT(e, BIGDECIMAL(1)),CONVERT(e, BIGDECIMAL(1,3)),CONVERT(e, DECIMAL(3,1)),CONVERT(e, DATE),CONVERT(e, TIME),CONVERT(e, TIMESTAMP),CONVERT(e, OBJECT),CONVERT(e, BLOB),CONVERT(e, CLOB),CONVERT(e, JSON),CONVERT(e, VARBINARY),CONVERT(e, GEOMETRY),CONVERT(e, GEOGRAPHY),CONVERT(e, XML),CONVERT(e, other_type),CONVERT(e, other_type[])
        FROM a |}]
