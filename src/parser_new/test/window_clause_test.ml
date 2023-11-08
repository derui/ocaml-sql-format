module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_window_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| window abc as (partition by d) |} p |> print_endline;
  Util.run {| window abc as (partition by d), cde as (c partition by v order by b.b desc) |} p |> print_endline;

  [%expect
    {|
    window abc as (partition by d)
    window abc as (partition by d), cde as (c partition by v order by b.b desc) |}]
