open Types.Token
module T = Syntax.Trivia

let%test_unit "leading trivia can contains newline and line comment" =
  T.leading
    [ Tok_space
    ; Tok_newline
    ; Tok_line_comment "com"
    ; Tok_block_comment "block"
    ]
  |> ignore;
  assert true

let%test_unit "trailing trivia can not contain newline and line comment" =
  try
    T.trailing
      [ Tok_space
      ; Tok_newline
      ; Tok_line_comment "com"
      ; Tok_block_comment "block"
      ]
    |> ignore;
    failwith "Invalid"
  with _ -> ()

let%expect_test "trivia to string" =
  Printf.printf "%s" @@ T.to_string
  @@ T.leading
       [ Tok_space
       ; Tok_newline
       ; Tok_line_comment "-- comment\n"
       ; Tok_newline
       ; Tok_block_comment "/* block */"
       ];
  [%expect {|
    -- comment

    /* block */ |}]
