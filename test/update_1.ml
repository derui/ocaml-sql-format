module F = Formatter
module P = Parser.Parser

let actual = {|
  update "tbl" set a = 3
|}

let option = F.Options.default

let%test_unit "update_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "update_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    UPDATE "tbl"
    SET
        a = 3; |}]
