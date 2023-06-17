module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT abc as a_b_c,b,c,d , e
|}

let option = F.Options.default

let%test_unit "column for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "column for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {| SELECT abc AS a_b_c,b,c,d,e |}]
