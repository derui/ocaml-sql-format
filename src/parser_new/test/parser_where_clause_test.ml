module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_where_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| WHERE table_name = 3 |} p |> print_endline;
  Util.run {| where 1 * 3 + 53 != 3 |} p |> print_endline;

  [%expect {|
    WHERE table_name = 3
    where 1 * 3 + 53 != 3 |}]
