module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create table a (
 b varchar(2) constraint pk primary key not null unique,
 c decimal(1) check (c > 3),
 e blob collate something constraint pp generated always as (3)
)
|}

let option = F.Options.default

let%test_unit "create_table_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_table_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TABLE a (
        b varchar(2) CONSTRAINT pk PRIMARY KEY NOT NULL UNIQUE,
        c decimal(1) CHECK(c > 3),
        e blob COLLATE something CONSTRAINT pp GENERATED ALWAYS AS(3)
    ); |}]
