module F = Formatter
module P = Parser.Parser

let actual =
  {|
  insert into a (a,b,c,d,e)
select 1,2,3,4,5 from v where a = 'c' and b like '%afb'
returning id, id2
|}

let option = F.Options.default

let%test_unit "insert_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "insert_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {||}]
