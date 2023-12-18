module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_common_value_expression.generate (P.Slot.get_taker ())

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

let%expect_test "parse identifier" =
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
  [%expect {|
    +"name"
    -ident
    |}]

let%expect_test "binary operator" =
  Util.run {| 1 + 2 |} p |> print_endline;
  Util.run {| 2 - 3 |} p |> print_endline;
  Util.run {| 3 * id|} p |> print_endline;
  Util.run {| id / f |} p |> print_endline;
  Util.run "8 && 7" p |> print_endline;
  Util.run "'foo' || 'bar'  " p |> print_endline;
  Util.run "3 + 4 - 5" p |> print_endline;
  Util.run "(3 + 4) - 5" p |> print_endline;
  [%expect
    {|
     1 + 2
     2 - 3
     3 * id
     id / f
    8 && 7
    'foo' || 'bar'
    3 + 4 - 5
    (3 + 4) - 5 |}]
