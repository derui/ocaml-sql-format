module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_select_stmt.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| select 1 |} p |> print_endline;
  Util.run {| with some_table as (select 1) select a,b,c from some_table |} p
  |> print_endline;
  Util.run {| select a,b,c from some_table order by a desc nulls first |} p
  |> print_endline;
  Util.run
    {| select a,b,c from some_table
            order by a
            limit 5 offset 2|}
    p
  |> print_endline;
  Util.run {| select a,b,c from some_table
            limit 5 offset 2|} p
  |> print_endline;
  Util.run {| select a,b,c from some_table
            where a > 3 |} p
  |> print_endline;
  Util.run
    {| select a,b,c from some_table
            where a > 3 union select c,d,e from other_table |}
    p
  |> print_endline;
  Util.run
    {| select a,b,c from some_table
            where a > 3 union all select c,d,e from other_table |}
    p
  |> print_endline;
  Util.run
    {| select a,b,c from some_table
            where a > 3 intersect select c,d,e from other_table |}
    p
  |> print_endline;
  Util.run
    {| select a,b,c from some_table
            where a > 3 except select c,d,e from other_table
     order by d |}
    p
  |> print_endline;

  [%expect
    {|
    select 1
    with some_table as (select 1) select a,b,c from some_table
    select a,b,c from some_table order by a desc nulls first
    select a,b,c from some_table
    order by a
    limit 5 offset 2
    select a,b,c from some_table
    limit 5 offset 2
    select a,b,c from some_table
    where a > 3
    select a,b,c from some_table
    where a > 3 union select c,d,e from other_table
    select a,b,c from some_table
    where a > 3 union all select c,d,e from other_table
    select a,b,c from some_table
    where a > 3 intersect select c,d,e from other_table
    select a,b,c from some_table
    where a > 3 except select c,d,e from other_table
    order by d |}]
