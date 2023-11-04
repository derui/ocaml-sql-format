module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_group_by_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| GROUP by a.b, c.e |} p |> print_endline;
  Util.run {| group BY a.b |} p |> print_endline;

  [%expect {|
    GROUP by a.b, c.e
    group BY a.b |}]
