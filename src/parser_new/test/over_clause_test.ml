module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_over_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| over () |} p |> print_endline;
  Util.run {| over window_name |} p |> print_endline;
  Util.run {| over (partition by a,c) |} p |> print_endline;
  Util.run {| over (partition by a,c order by a desc) |} p |> print_endline;
  Util.run {| over (partition by a,c order by a desc range current row) |} p |> print_endline;
  Util.run {| over (partition by a,c range current row) |} p |> print_endline;
  Util.run {| over (range current row) |} p |> print_endline;
  Util.run {| over (order by a desc range current row) |} p |> print_endline;
  Util.run {| over (abc order by a desc range current row) |} p |> print_endline;

  [%expect
    {|
    over ()
    over window_name
    over (partition by a,c)
    over (partition by a,c order by a desc)
    over (partition by a,c order by a desc range current row)
    over (partition by a,c range current row)
    over (range current row)
    over (order by a desc range current row)
    over (abc order by a desc range current row) |}]
