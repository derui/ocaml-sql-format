module F = Formatter
module P = Parser.Parser

let actual =
  {|
  with a as (
 select 1 from b
), "abc" (e) as (select 2 from c)
select * from a, "abc"
|}

let option = F.Options.default

let%test_unit "select_4 for AST" =
  print_string @@ F.from_string ~option actual;
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {||}]
