let%expect_test "simple select" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Syntax.show_syntax v));

  [%expect
    {|
    (Syntax.Sy_keyword (Syntax.Ky_select "SELECT"))
    Syntax.Sy_asterisk
    (Syntax.Sy_keyword (Syntax.Ky_from "FROM"))
    (Syntax.Sy_ident "test") |}]

let%expect_test "as keyword" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test as v" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Syntax.show_syntax v));

  [%expect
    {|
    (Syntax.Sy_keyword (Syntax.Ky_select "SELECT"))
    Syntax.Sy_asterisk
    (Syntax.Sy_keyword (Syntax.Ky_from "FROM"))
    (Syntax.Sy_ident "test")
    (Syntax.Sy_keyword (Syntax.Ky_as "as"))
    (Syntax.Sy_ident "v") |}]

let%expect_test "parens" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test as v ()" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Syntax.show_syntax v));

  [%expect
    {|
    (Syntax.Sy_keyword (Syntax.Ky_select "SELECT"))
    Syntax.Sy_asterisk
    (Syntax.Sy_keyword (Syntax.Ky_from "FROM"))
    (Syntax.Sy_ident "test")
    (Syntax.Sy_keyword (Syntax.Ky_as "as"))
    (Syntax.Sy_ident "v")
    Syntax.Sy_lparen
    Syntax.Sy_rparen |}]
