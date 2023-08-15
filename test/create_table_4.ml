module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create temporary table if not exists public.foo as select a,b,c from c_d inner join e_f on id = a_id
|}

let option = F.Options.default

let%test_unit "create_table_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_table_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TEMPORARY TABLE IF NOT EXISTS public.foo AS
        SELECT
            a,
            b,
            c
        FROM
            c_d
            INNER JOIN e_f
                ON id = a_id; |}]
