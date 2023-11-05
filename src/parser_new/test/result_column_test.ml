module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_result_column.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| 35 + 3 |} p |> print_endline;
  Util.run {| 3 as alias_name |} p |> print_endline;
  Util.run {| 3 alias_name |} p |> print_endline;
  Util.run {| * |} p |> print_endline;
  Util.run {| b.* |} p |> print_endline;

  [%expect {|
    35 + 3
    3 as alias_name
    3 alias_name
    *
    b.* |}]
