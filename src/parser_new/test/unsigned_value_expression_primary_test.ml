module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_unsigned_value_expression_primary.generate (P.Slot.get_taker ())

let%expect_test "parse bind parameter" =
  Util.run "   ?   " p |> print_endline;
  [%expect {| ? |}]

let%expect_test "parse name" =
  Util.run {| "name" |} p |> print_endline;
  Util.run {| table_a."name" |} p |> print_endline;
  Util.run {| schema_b.table_a."name" |} p |> print_endline;
  [%expect {|
    "name"
    table_a."name"
    schema_b.table_a."name" |}]

let%expect_test "function" =
  Util.run "func(1)" p |> print_endline;
  Util.run "func(1, f2(*))" p |> print_endline;
  Util.run "func()" p |> print_endline;
  Util.run "func(  *   )" p |> print_endline;
  Util.run "func(  distinct 1, 3 , 'a'   )" p |> print_endline;
  Util.run "func(  distinct 1, 3 , 'a' order by 3 desc )" p |> print_endline;
  Util.run "func() filter (where 'data')" p |> print_endline;
  Util.run "func() over (partition by c)" p |> print_endline;
  Util.run "func() filter (where 'foo') over (partition by c)" p |> print_endline;
  Util.run "count(*)" p |> print_endline;
  Util.run "sum(x)" p |> print_endline;
  Util.run "avg(x)" p |> print_endline;
  Util.run "min(x)" p |> print_endline;
  Util.run "max(x)" p |> print_endline;
  Util.run "every(x)" p |> print_endline;
  Util.run "some(x)" p |> print_endline;
  Util.run "any(x,y)" p |> print_endline;
  [%expect
    {|
    func(1)
    func(1, f2(*))
    func()
    func( * )
    func( distinct 1, 3 , 'a' )
    func( distinct 1, 3 , 'a' order by 3 desc )
    func() filter (where 'data')
    func() over (partition by c)
    func() filter (where 'foo') over (partition by c)
    count(*)
    sum(x)
    avg(x)
    min(x)
    max(x)
    every(x)
    some(x)
    any(x,y) |}]

let%expect_test "wrap parens" =
  Util.run "( 1 )" p |> print_endline;
  Util.run "( 1, 3 , 'a' , \"b\")" p |> print_endline;
  Util.run "(1, (3), (4))" p |> print_endline;
  [%expect {|
    ( 1 )
    ( 1, 3 , 'a' , "b")
    (1, (3), (4)) |}]

let%expect_test "case" =
  Util.run "case when 'a' then 3 end" p |> print_endline;
  Util.run {|CASE
            when 'f' then 3
            when 'e' then 4
            else 5
            END|} p
  |> print_endline;
  Util.run {|CASE foobar
            when 'f' then 3
            when 'e' then 4
            else 5
            END|} p
  |> print_endline;
  [%expect
    {|
    case when 'a' then 3 end
    CASE
     when 'f' then 3
     when 'e' then 4
     else 5
     END
    CASE foobar
     when 'f' then 3
     when 'e' then 4
     else 5
     END |}]
