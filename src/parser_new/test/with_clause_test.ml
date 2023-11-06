module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_with_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| with some_table as (select 1) |} p |> print_endline;
  Util.run {| with some_table as (select 1), next_name as (select a,b from c) |}
    p
  |> print_endline;
  Util.run
    {| with recursive some_table as (select 1), next_name as (select a,b from c) |}
    p
  |> print_endline;

  [%expect
    {|
    with some_table as (select 1)
    with some_table as (select 1), next_name as (select a,b from c)
    with recursive some_table as (select 1), next_name as (select a,b from c) |}]
