module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_non_numeric_literal.generate (P.Slot.get_taker ())

let%expect_test "parse string" =
  Util.run {| 'string' |} p |> print_endline;
  [%expect {| 'string' |}]

let%expect_test "parse blob" =
  Util.run {| x'blob' |} p |> print_endline;
  Util.run {| x'large blob' |} p |> print_endline;
  [%expect {|
    x'blob'
    x'large blob' |}]

let%expect_test "parse null" =
  Util.run {| null |} p |> print_endline;
  Util.run {| NULL |} p |> print_endline;
  [%expect {|
    null
    NULL |}]

let%expect_test "parse true" =
  Util.run {| true |} p |> print_endline;
  Util.run {| TRUE |} p |> print_endline;
  [%expect {|
    true
    TRUE |}]

let%expect_test "parse false" =
  Util.run {| false |} p |> print_endline;
  Util.run {| FALSE |} p |> print_endline;
  [%expect {|
    false
    FALSE |}]

let%expect_test "parse current_time" =
  Util.run {| current_time |} p |> print_endline;
  Util.run {| CURRENT_TIME |} p |> print_endline;
  [%expect {|
    current_time
    CURRENT_TIME |}]

let%expect_test "parse current_date" =
  Util.run {| current_date |} p |> print_endline;
  Util.run {| CURRENT_DATE |} p |> print_endline;
  [%expect {|
    current_date
    CURRENT_DATE |}]

let%expect_test "parse current_timestamp" =
  Util.run {| current_timestamp |} p |> print_endline;
  Util.run {| CURRENT_TIMESTAMP |} p |> print_endline;
  [%expect {|
    current_timestamp
    CURRENT_TIMESTAMP |}]
