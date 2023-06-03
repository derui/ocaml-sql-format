let%expect_test "simple select" =
  let buf = Sedlexing.Utf8.from_string "SELECT * FROM test" in
  Lexer.token buf []
  |> List.iter (fun v -> Printf.printf "%s\n" (Lexer.Syntax.show_syntax v));

  [%expect
    {|
    (Syntax.Sy_keyword (Syntax.Ky_select "SELECT"))
    (Syntax.Sy_keyword Syntax.Ky_asterisk)
    (Syntax.Sy_keyword (Syntax.Ky_from "FROM"))
    (Syntax.Sy_ident "test") |}]
