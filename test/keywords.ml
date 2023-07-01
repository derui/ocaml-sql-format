module F = Formatter
module P = Parser.Parser

let actual = {|
  SeleCt *
|}

let option = F.Options.default

let%test_unit "keyword for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "lower for formatting" =
  print_endline @@ F.from_string actual ~option:{ option with keyword = `Lower };
  [%expect {|
    select
        * |}]

let%expect_test "upper for formatting" =
  print_endline @@ F.from_string actual ~option:{ option with keyword = `Upper };
  [%expect {|
    SELECT
        * |}]
