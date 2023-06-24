module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
 textagg (for a as t1, b as t2 delimiter ',' quote 'a' header encoding "euc-jp") as v,
 textagg (for a as t1, b as t2 delimiter ',' no quote order by t2) as v2,
 textagg (for a as t1, b as t2 delimiter ',') as v3
from a
|}

let option = F.Options.default

let%test_unit "select_8 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_8 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {| SELECT TEXTAGG ( FOR a AS t1, b AS t2 DELIMITER ',' QUOTE 'a' ENCODING "euc-jp") AS v,TEXTAGG ( FOR a AS t1, b AS t2 DELIMITER ',' NO QUOTE ORDER BY t2) AS v2,TEXTAGG ( FOR a AS t1, b AS t2 DELIMITER ',') AS v3  FROM a |}]
