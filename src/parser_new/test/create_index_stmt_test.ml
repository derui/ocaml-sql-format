module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_create_index_stmt.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| create index b on foo (c,d,e asc) |} p |> print_endline;
  Util.run {| create unique index b on foo (c,d,e asc) |} p |> print_endline;
  Util.run {| create index if not exists b on foo (c,d,e asc) |} p |> print_endline;
  Util.run {| create index c.b on foo (c,d,e asc) |} p |> print_endline;
  Util.run {| create index c.b on foo (c,d,e asc) where d == 50 |} p |> print_endline;

  [%expect
    {|
    create index b on foo (c,d,e asc)
    create unique index b on foo (c,d,e asc)
    create index if not exists b on foo (c,d,e asc)
    create index c.b on foo (c,d,e asc)
    create index c.b on foo (c,d,e asc) where d == 50 |}]
