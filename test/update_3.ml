module F = Formatter
module P = Parser.Parser

let actual = {|
  update sche.tbl as c set a = 3, b = 4 where c >= 10
|}

let option = F.Options.default

let%test_unit "update_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "update_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    UPDATE sche.tbl AS c
    SET
        a = 3,
        b = 4
    WHERE
        c >= 10 |}]
