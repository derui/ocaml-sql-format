module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_type_name.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| column_name |} p |> print_endline;
  Util.run {| multi "column" "name" (+350) |} p |> print_endline;
  Util.run {| some_column (-3,+50) |} p |> print_endline;

  [%expect {|
    column_name
    multi "column" "name" (+350)
    some_column (-3,+50) |}]
