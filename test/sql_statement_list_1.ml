module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create table public.foo (
 id bigint primary key
);

alter table foo rename to foo_bar;

select * from foo_bar where id < 100 and id between 10 and 50;
|}

let option = F.Options.default

let%test_unit "sql_statement_list_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "sql_statement_list_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TABLE public.foo (
        id bigint PRIMARY KEY
    );

    ALTER TABLE foo RENAME TO foo_bar;

    SELECT
        *
    FROM
        foo_bar
    WHERE
        id < 100 AND id BETWEEN 10 AND 50; |}]
