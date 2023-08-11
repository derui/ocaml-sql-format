module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create table a (
 b varchar constraint pk primary key,
 c decimal(1)
)
|}

let option = F.Options.default

let%test_unit "create_table_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_table_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TABLE a (
        b varchar CONSTRAINT pk PRIMARY KEY,
        c decimal(1)
    ) |}]
