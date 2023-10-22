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
  [%expect
    {|
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
    7 >= 4
    8 & 7
    9 | 7
    'foo'
    1 >> 2
    rshift <<2
    ex->3
    ex->>4
    3 + 4 - 5
    (3 + 4) - 5 |}]

let%expect_test "function" =
  Util.run "func(1)" p |> print_endline;
  Util.run "func(1, f2(*))" p |> print_endline;
  Util.run "func()" p |> print_endline;
  Util.run "func(  *   )" p |> print_endline;
  Util.run "func(  distinct 1, 3 , 'a'   )" p |> print_endline;
  Util.run "func() filter (where 'data')" p |> print_endline;
  [%expect
    {|
    func(1)
    func(1, f2(*))
    func()
    func( * )
    func( distinct 1, 3 , 'a' )
    func() filter (where 'data') |}]

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
  [%expect
    {|
    3 collate foo
    func(3) collate foo
    (func(3), 5)
     collate foo |}]

let%expect_test "like" =
  Util.run "list like 'abc%'" p |> print_endline;
  Util.run "list not like 'abc%'" p |> print_endline;
  Util.run "list like 35 escape 'a'" p |> print_endline;
  [%expect
    {|
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
