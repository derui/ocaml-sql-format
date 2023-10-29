module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_join_clause.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| table_name |} p |> print_endline;
  Util.run {| schem."name", other |} p |> print_endline;
  Util.run {| "name", other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" natural join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" cross join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" left join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" left  outer join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" natural left join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" natural left  outer join other on a.b = c.d |} p
  |> print_endline;
  Util.run {| "name" right  join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" right outer join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" natural right  join other on a.b = c.d |} p
  |> print_endline;
  Util.run {| "name" natural right outer join other on a.b = c.d |} p
  |> print_endline;
  Util.run {| "name" full  join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" full outer join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" natural full  join other on a.b = c.d |} p |> print_endline;
  Util.run {| "name" natural full outer join other on a.b = c.d |} p
  |> print_endline;
  Util.run {| "name" natural full outer join other using (b) |} p
  |> print_endline;
  Util.run {| "name" natural inner join other using (b, d, e) |} p
  |> print_endline;

  [%expect
    {|
     table_name
     schem."name", other
     "name", other on a.b = c.d
     "name" join other on a.b = c.d
     "name" natural join other on a.b = c.d
     "name" cross join other on a.b = c.d
     "name" left join other on a.b = c.d
     "name" left outer join other on a.b = c.d
     "name" natural left join other on a.b = c.d
     "name" natural left outer join other on a.b = c.d
     "name" right join other on a.b = c.d
     "name" right outer join other on a.b = c.d
     "name" natural right join other on a.b = c.d
     "name" natural right outer join other on a.b = c.d
     "name" full join other on a.b = c.d
     "name" full outer join other on a.b = c.d
     "name" natural full join other on a.b = c.d
     "name" natural full outer join other on a.b = c.d
     "name" natural full outer join other using (b)
     "name" natural inner join other using (b, d, e) |}]
