module F = Formatter
module P = Parser.Parser

let actual = {|
  insert into a (a,b,c,d,e) values (1, 2, 3),(4,5,6),(7,8,9)
|}

let option = F.Options.default

let%test_unit "insert_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "insert_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    INSERT INTO a (
        a,
        b,
        c,
        d,
        e
    )
    VALUES
        (1, 2, 3),
        (4, 5, 6),
        (7, 8, 9) |}]
