module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
   listagg('abc') within group (order by a, b desc)
  ,listagg("array", 'foo') within group (order by a asc)
from a
|}

let option = F.Options.default

let%test_unit "function_11 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_11 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {| SELECT LISTAGG('abc') WITHIN GROUP (ORDER BY a,b DESC),LISTAGG("array",'foo') WITHIN GROUP (ORDER BY a ASC)  FROM a |}]
