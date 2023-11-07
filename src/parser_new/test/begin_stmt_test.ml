module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_begin_stmt.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| begin |} p |> print_endline;
  Util.run {| begin transaction|} p |> print_endline;

  [%expect {|
    begin
    begin transaction |}]
