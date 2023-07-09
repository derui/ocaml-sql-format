module F = Formatter
module P = Parser.Parser

let actual =
  {|
  with a as (
  select 1
) search depth first by a
,b as (
select a, b from table_c
) search breadth first by b asc
,c as (
select abc, "path" from table_d
) cycle abc set abc to 3 default 1 using "path"
,d as (
select b, abc, "path" from table_d
) search breadth first by b asc cycle abc set abc to 3 default 1 using "path"
select
  *
from a
|}

let option = F.Options.default

let%test_unit "select_16 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_16 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {||}]
