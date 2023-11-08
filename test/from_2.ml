module F = Formatter
module P = Parser.Parser

let actual = {|
  SELECT * from test_table abc, ident as "next",
               third
|}

let option = F.Options.default

let%test_unit "multiple tables in from for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "multiple tables in from for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect {|
    SELECT
        *
    FROM
        test_table AS abc,
        ident AS "next",
        third; |}]
