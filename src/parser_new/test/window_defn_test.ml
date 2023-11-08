module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_window_defn.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| () |} p |> print_endline;
  Util.run {| (partition by a,c) |} p |> print_endline;
  Util.run {| (partition by a,c order by a desc) |} p |> print_endline;
  Util.run {| (partition by a,c order by a desc range current row) |} p |> print_endline;
  Util.run {| (partition by a,c range current row) |} p |> print_endline;
  Util.run {| (range current row) |} p |> print_endline;
  Util.run {| (order by a desc range current row) |} p |> print_endline;
  Util.run {| (abc order by a desc range current row) |} p |> print_endline;

  [%expect
    {|
    ()
    (partition by a,c)
    (partition by a,c order by a desc)
    (partition by a,c order by a desc range current row)
    (partition by a,c range current row)
    (range current row)
    (order by a desc range current row)
    (abc order by a desc range current row) |}]
