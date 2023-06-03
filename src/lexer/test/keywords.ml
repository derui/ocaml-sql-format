let%expect_test "simple select" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Token.show_token v));

  [%expect
    {|
    (Token.Tok_keyword (Token.Ky_select "SELECT"))
    Token.Tok_asterisk
    (Token.Tok_keyword (Token.Ky_from "FROM"))
    (Token.Tok_ident "test") |}]

let%expect_test "as keyword" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test as v" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Token.show_token v));

  [%expect
    {|
    (Token.Tok_keyword (Token.Ky_select "SELECT"))
    Token.Tok_asterisk
    (Token.Tok_keyword (Token.Ky_from "FROM"))
    (Token.Tok_ident "test")
    (Token.Tok_keyword (Token.Ky_as "as"))
    (Token.Tok_ident "v") |}]

let%expect_test "parens" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test as v ()" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Token.show_token v));

  [%expect
    {|
    (Token.Tok_keyword (Token.Ky_select "SELECT"))
    Token.Tok_asterisk
    (Token.Tok_keyword (Token.Ky_from "FROM"))
    (Token.Tok_ident "test")
    (Token.Tok_keyword (Token.Ky_as "as"))
    (Token.Tok_ident "v")
    Token.Tok_lparen
    Token.Tok_rparen |}]
