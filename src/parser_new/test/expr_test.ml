module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_expr.generate (P.Slot.get_taker ())

let%expect_test "parse literal" =
  Util.run {| 'string' |} p |> print_endline;
  Util.run {| 100005 |} p |> print_endline;
  Util.run {| x'blob' |} p |> print_endline;
  Util.run {| x'large blob' |} p |> print_endline;
  Util.run {| null |} p |> print_endline;
  Util.run {| NULL |} p |> print_endline;
  Util.run {| true |} p |> print_endline;
  Util.run {| TRUE |} p |> print_endline;

  Util.run {| false |} p |> print_endline;
  Util.run {| FALSE |} p |> print_endline;

  Util.run {| current_time |} p |> print_endline;
  Util.run {| CURRENT_TIME |} p |> print_endline;

  Util.run {| current_date |} p |> print_endline;
  Util.run {| CURRENT_DATE |} p |> print_endline;
  Util.run {| current_timestamp |} p |> print_endline;
  Util.run {| CURRENT_TIMESTAMP |} p |> print_endline;
  [%expect
    {|
    'string'
    100005
    x'blob'
    x'large blob'
    null
    NULL
    true
    TRUE
    false
    FALSE
    current_time
    CURRENT_TIME
    current_date
    CURRENT_DATE
    current_timestamp
    CURRENT_TIMESTAMP |}]

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

let%expect_test "unary operator" =
  Util.run {| +"name" |} p |> print_endline;
  Util.run {| -ident |} p |> print_endline;
  Util.run {| ~ident |} p |> print_endline;
  Util.run {| not ident |} p |> print_endline;
  [%expect {|
    +"name"
    -ident
    ~ident
    not ident |}]

let%expect_test "binary operator" =
  Util.run {| 1 + 2 |} p |> print_endline;
  Util.run {| 2 - 3 |} p |> print_endline;
  Util.run {| 3 * id|} p |> print_endline;
  Util.run {| id / f |} p |> print_endline;
  Util.run {| eq = eq |} p |> print_endline;
  Util.run {| 1 == 2 |} p |> print_endline;
  Util.run {| 3 <> 4 |} p |> print_endline;
  Util.run "4 != 4" p |> print_endline;
  Util.run "5 < 4" p |> print_endline;
  Util.run "6 <= 5" p |> print_endline;
  Util.run "7 > 3" p |> print_endline;
  Util.run "7 >= 4" p |> print_endline;
  Util.run "8 & 7" p |> print_endline;
  Util.run "9 | 7" p |> print_endline;
  Util.run "'foo' || 'bar'  " p |> print_endline;
  Util.run "1 >> 2" p |> print_endline;
  Util.run "rshift <<2" p |> print_endline;
  Util.run "ex->3" p |> print_endline;
  Util.run "ex->>4" p |> print_endline;
  Util.run "3 + 4 - 5" p |> print_endline;
  Util.run "(3 + 4) - 5" p |> print_endline;
  [%expect.unreachable]
[@@expect.uncaught_exn
  {|
  (* CR expect_test_collector: This test expectation appears to contain a backtrace.
     This is strongly discouraged as backtraces are fragile.
     Please change this test to not include a backtrace. *)

  (Failure "Malformed source: `'")
  Raised at Stdlib.failwith in file "stdlib.ml", line 29, characters 17-33
  Called from Parser_monad__Tokenizer.tokenize.loop in file "src/parser_monad/tokenizer.ml", line 13, characters 14-29
  Called from Parser_monad__Tokenizer.tokenize in file "src/parser_monad/tokenizer.ml", line 21, characters 6-13
  Called from Parser_new_test__Util.run in file "src/parser_new/test/util.ml", line 5, characters 14-82
  Called from Parser_new_test__Expr_test.(fun) in file "src/parser_new/test/expr_test.ml", line 84, characters 2-20
  Called from Expect_test_collector.Make.Instance_io.exec in file "collector/expect_test_collector.ml", line 234, characters 12-19

  Trailing output
  ---------------
   1 + 2
   2 - 3
   3 * id
   id / f
   eq = eq
   1 == 2
   3 <> 4
  4 != 4
  5 < 4
  6 <= 5
  7 > 3
  7 >= 4 |}]

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

let%expect_test "cast" =
  Util.run "cast( data_column as integer (3) )" p |> print_endline;
  [%expect {|
    cast( data_column as integer (3) ) |}]

let%expect_test "collate" =
  Util.run "3 collate foo" p |> print_endline;
  Util.run "func(3) collate foo" p |> print_endline;
  Util.run "(func(3), 5)\n            collate foo" p |> print_endline;
  [%expect {|
    3 collate foo
    func(3) collate foo
    (func(3), 5)
     collate foo |}]

let%expect_test "like" =
  Util.run "list like 'abc%'" p |> print_endline;
  Util.run "list not like 'abc%'" p |> print_endline;
  Util.run "list like 35 escape 'a'" p |> print_endline;
  [%expect {|
    list like 'abc%'
    list not like 'abc%'
    list like 35 escape 'a' |}]

let%expect_test "glob/regexp/match" =
  Util.run "list GLOB 'abc%'" p |> print_endline;
  Util.run "list not GLOB 'abc%'" p |> print_endline;
  Util.run "list regexp 'abc%'" p |> print_endline;
  Util.run "list not regexp 'abc%'" p |> print_endline;
  Util.run "list match 'abc%'" p |> print_endline;
  Util.run "list not match 'abc%'" p |> print_endline;
  [%expect
    {|
    list GLOB 'abc%'
    list not GLOB 'abc%'
    list regexp 'abc%'
    list not regexp 'abc%'
    list match 'abc%'
    list not match 'abc%' |}]

let%expect_test "is" =
  Util.run "list is null" p |> print_endline;
  Util.run "list is not NULL" p |> print_endline;
  Util.run "list is distinct from 'abc%'" p |> print_endline;
  Util.run "list is not distinct from 'abc%'" p |> print_endline;
  [%expect
    {|
    list is null
    list is not NULL
    list is distinct from 'abc%'
    list is not distinct from 'abc%' |}]

let%expect_test "between" =
  Util.run "list between t and f" p |> print_endline;
  Util.run "list not between 3 and 300" p |> print_endline;
  [%expect {|
    list between t and f
    list not between 3 and 300 |}]

let%expect_test "in" =
  Util.run "list in (1)" p |> print_endline;
  Util.run "list in (1,'3', 4)" p |> print_endline;
  Util.run "list not in (1,'3', 4)" p |> print_endline;
  Util.run "list  in tbl" p |> print_endline;
  Util.run "list  in public.tbl" p |> print_endline;
  Util.run "list  in func()" p |> print_endline;
  Util.run "list  in func(1)" p |> print_endline;
  Util.run "list  in func(1,3)" p |> print_endline;
  [%expect
    {|
    list in (1)
    list in (1,'3', 4)
    list not in (1,'3', 4)
    list in tbl
    list in public.tbl
    list in func()
    list in func(1)
    list in func(1,3) |}]

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

let%expect_test "exists" =
  Util.run "exists (select 3)" p |> print_endline;
  Util.run "not exists (select 3)" p |> print_endline;

  [%expect {|
    exists (select 3)
    not exists (select 3) |}]
