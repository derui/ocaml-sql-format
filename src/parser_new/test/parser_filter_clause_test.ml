module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_filter_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| FILTER   ( where 3 ) |} p |> print_endline;

  [%expect {|
    FILTER ( where 3 ) |}]
