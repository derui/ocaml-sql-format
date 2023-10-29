module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_table_or_subquery.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| table_name |} p |> print_endline;
  Util.run {| schem."name" |} p |> print_endline;
  Util.run {| f as other_name |} p |> print_endline;
  Util.run {| f other_name |} p |> print_endline;
  Util.run {| f(1,3) |} p |> print_endline;
  Util.run {| f('fo') |} p |> print_endline;
  Util.run {| f('fo') as other_name |} p |> print_endline;
  Util.run {| f('fo') other_name |} p |> print_endline;

  [%expect
    {|
     table_name
     schem."name"
     f as other_name
     f other_name
     f(1,3)
     f('fo')
     f('fo') as other_name
     f('fo') other_name |}]
