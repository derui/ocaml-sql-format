module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_common_table_expression.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| some_table as (select 1) |} p |> print_endline;
  Util.run {| some_table as materialized (select 1) |} p |> print_endline;
  Util.run {| some_table as not (select 1) |} p |> print_endline;
  Util.run {| some_table as not materialized (select a,b,c from table_c) |} p
  |> print_endline;

  [%expect
    {|
    some_table as (select 1)
    some_table as materialized (select 1)
    some_table as not (select 1)
    some_table as not materialized (select a,b,c from table_c) |}]
