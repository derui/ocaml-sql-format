module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_frame_spec.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| RANGE between 3 preceding and 5 following |} p |> print_endline;
  Util.run {| RANGE between unbounded preceding and unbounded following |} p |> print_endline;
  Util.run {| RANGE between current row and current row |} p |> print_endline;
  Util.run {| rows unbounded preceding |} p |> print_endline;
  Util.run {| Groups 5 preceding |} p |> print_endline;
  Util.run {| RANGE current row |} p |> print_endline;
  Util.run {| RANGE current row exclude no others |} p |> print_endline;
  Util.run {| RANGE current row exclude current row |} p |> print_endline;
  Util.run {| RANGE current row exclude group |} p |> print_endline;
  Util.run {| RANGE current row exclude ties |} p |> print_endline;

  [%expect
    {|
    RANGE between 3 preceding and 5 following
    RANGE between unbounded preceding and unbounded following
    RANGE between current row and current row
    rows unbounded preceding
    Groups 5 preceding
    RANGE current row
    RANGE current row exclude no others
    RANGE current row exclude current row
    RANGE current row exclude group
    RANGE current row exclude ties |}]
