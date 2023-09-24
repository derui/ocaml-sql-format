module F = Formatter
module P = Parser.Parser

let actual =
  {|
  /*
    sample block comment
*/

create index a on foo (a,b,c)
|}

let option = F.Options.default

let%test_unit "comment_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "comment_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE INDEX a ON foo (
        a,
        b,
        c
    ); |}]
