module F = Formatter
module P = Parser.Parser

let actual = {|
  update sche.tbl set a = 3, b = 4
|}

let option = F.Options.default

let%test_unit "update_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "update_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    UPDATE sche.tbl
    SET
        a = 3,
        b = 4 |}]
