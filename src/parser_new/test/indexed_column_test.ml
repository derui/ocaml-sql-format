module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_indexed_column.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| "name" |} p |> print_endline;
  Util.run {| +31 |} p |> print_endline;
  Util.run {| foo collate c_name |} p |> print_endline;
  Util.run {| foo asc |} p |> print_endline;
  Util.run {| foo desc |} p |> print_endline;

  [%expect
    {|
    "name"
    +31
    foo collate c_name
    foo asc
    foo desc |}]
