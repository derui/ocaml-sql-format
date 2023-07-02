module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
   current_timestamp
  ,current_time
  ,current_timestamp(3)
  ,current_time(4)
  ,session_user
from a
|}

let option = F.Options.default

let%test_unit "function_14 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_14 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          CURRENT_TIMESTAMP,CURRENT_TIME,CURRENT_TIMESTAMP(3),CURRENT_TIME(4),
          SESSION_USER
      FROM
          a |}]