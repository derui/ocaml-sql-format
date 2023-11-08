module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_returning_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| returning * |} p |> print_endline;
  Util.run {| returning a,b |} p |> print_endline;
  Util.run {| returning c as foo, d other, * |} p |> print_endline;

  [%expect {|
    returning *
    returning a,b
    returning c as foo, d other, * |}]
