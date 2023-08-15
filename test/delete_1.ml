module F = Formatter
module P = Parser.Parser

let actual = {|
  delete from other_table where id >= 50
|}

let option = F.Options.default

let%test_unit "delete_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "delete_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    DELETE FROM other_table
    WHERE
        id >= 50; |}]
