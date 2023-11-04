module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_order_by_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| order by table_name |} p |> print_endline;
  Util.run {| order by a,b,c |} p |> print_endline;
  Util.run {| order by a asc,b desc,c asc nulls first |} p |> print_endline;
  Util.run {| order by a desc nulls last |} p |> print_endline;

  [%expect
    {|
    order by table_name
    order by a,b,c
    order by a asc,b desc,c asc nulls first
    order by a desc nulls last |}]
