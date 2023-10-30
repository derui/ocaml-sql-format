module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_from_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| FROM table_name |} p |> print_endline;
  Util.run {| from schem."name" |} p |> print_endline;
  Util.run {| from f as other_name |} p |> print_endline;
  Util.run {| from f other_name |} p |> print_endline;
  Util.run {| from f(1,3) |} p |> print_endline;
  Util.run {| from f('fo') |} p |> print_endline;
  Util.run {| from f('fo') as other_name |} p |> print_endline;
  Util.run {| from f('fo') other_name |} p |> print_endline;
  Util.run {| from f('fo') other_name, other_table, foo |} p |> print_endline;
  Util.run {| from f('fo') inner join other_name using (id) |} p
  |> print_endline;

  [%expect
    {|
    FROM table_name
    from schem."name"
    from f as other_name
    from f other_name
    from f(1,3)
    from f('fo')
    from f('fo') as other_name
    from f('fo') other_name
    from f('fo') other_name, other_table, foo
    from f('fo') inner join other_name using (id) |}]
