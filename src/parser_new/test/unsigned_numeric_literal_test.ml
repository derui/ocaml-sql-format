module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_unsigned_numeric_literal.generate (P.Slot.get_taker ())

let%expect_test "parse numeric" =
  Util.run {| 100005 |} p |> print_endline;
  [%expect {| 100005 |}];

  Util.run {| 1.52 |} p |> print_endline;
  [%expect {| 1.52 |}]
