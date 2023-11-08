module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_select_core.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| select 1 |} p |> print_endline;
  Util.run {| select distinct a,b,c
                from z
            |} p |> print_endline;
  Util.run {| select all a,b,c
                from z
                group by b
            |} p |> print_endline;
  Util.run {| select all a,b,c
                from z
                having b > 0
            |} p |> print_endline;
  Util.run
    {| select all a,b,c
                from z
                having b > 0
                window wname as (partition by a)
            |}
    p
  |> print_endline;
  Util.run {| values (1,3,5 * 3) |} p |> print_endline;
  Util.run {| values (1,3,5 * 3), (3,7,9) |} p |> print_endline;

  [%expect
    {|
    select 1
    select distinct a,b,c
    from z
    select all a,b,c
    from z
    group by b
    select all a,b,c
    from z
    having b > 0
    select all a,b,c
    from z
    having b > 0
    window wname as (partition by a)
    values (1,3,5 * 3)
    values (1,3,5 * 3), (3,7,9) |}]
