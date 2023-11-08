module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_qualified_table_name.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| a |} p |> print_endline;
  Util.run {| a as alias |} p |> print_endline;
  Util.run {| c.a as alias |} p |> print_endline;

  [%expect {|
    a
    a as alias
    c.a as alias |}]
