module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_delete_stmt.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| delete from a |} p |> print_endline;
  Util.run {| with some_table as (select 1) delete from some_table |} p |> print_endline;
  Util.run {| delete from a.b where c > 10 and d = false |} p |> print_endline;
  Util.run {| delete from c returning * |} p |> print_endline;
  Util.run {| delete from c WHERE d = false returning id|} p |> print_endline;

  [%expect
    {|
    delete from a
    with some_table as (select 1) delete from some_table
    delete from a.b where c > 10 and d = false
    delete from c returning *
    delete from c WHERE d = false returning id |}]
