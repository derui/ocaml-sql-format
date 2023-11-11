module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_sql_stmt.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| select 1 |} p |> print_endline;
  Util.run {| explain select 1 |} p |> print_endline;
  Util.run {| explain analyze select 1 |} p |> print_endline;
  Util.run {| begin |} p |> print_endline;
  Util.run {| commit |} p |> print_endline;
  Util.run {| rollback |} p |> print_endline;
  Util.run {| delete from "f" |} p |> print_endline;
  Util.run {| create index a.b on dd (c,d) |} p |> print_endline;

  [%expect
    {|
      select 1
      explain select 1
      explain analyze select 1
      begin
      commit
      rollback
      delete from "f"
      create index a.b on dd (c,d) |}]
