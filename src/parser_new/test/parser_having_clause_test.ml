module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_having_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| having table_name = 3 |} p |> print_endline;
  Util.run {| HAVING 1 * 3 + 53 != 3 |} p |> print_endline;

  [%expect {|
    having table_name = 3
    HAVING 1 * 3 + 53 != 3 |}]
