module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT  t.* from "some_table name"
|}

let option = F.Options.default

let%test_unit "select into for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "select into for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    SELECT
        t
    FROM
        "some_table name"; |}]
