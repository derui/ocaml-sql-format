module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_limit_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| limit 50 |} p |> print_endline;
  Util.run {| limit 50 offset 30 |} p |> print_endline;
  Util.run {| limit 50, 40 |} p |> print_endline;

  [%expect {|
    limit 50
    limit 50 offset 30
    limit 50, 40 |}]
