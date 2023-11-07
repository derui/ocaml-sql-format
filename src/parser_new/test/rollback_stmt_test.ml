module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_rollback_stmt.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| rollback |} p |> print_endline;
  Util.run {| rollback transaction|} p |> print_endline;
  Util.run {| rollback to savepoint abc|} p |> print_endline;
  Util.run {| rollback transaction to savepoint abc|} p |> print_endline;

  [%expect
    {|
    rollback
    rollback transaction
    rollback to savepoint abc
    rollback transaction to savepoint abc |}]
