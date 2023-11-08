open Types.Token
module R = Sql_syntax.Raw
module T = Sql_syntax.Trivia
module L = Sql_syntax.Language

type kind =
  | A
  | B

let%test_unit "append syntax to language" =
  let lang = L.empty () in
  assert (L.to_string lang = "")

let%expect_test "language to string" =
  let syntax =
    R.make_node B
      ~layouts:
        [ R.make_leaf A ~leading:(T.leading [ Tok_newline ]) ~trailing:(T.trailing [ Tok_space ])
            ~token:(Tok_ident "ident")
        ; R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing [ Tok_space ]) ~token:Op_eq
        ; R.make_node B
            ~layouts:
              [ R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing []) ~token:(Tok_numeric "1")
              ; R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing []) ~token:Op_plus
              ; R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing []) ~token:(Tok_numeric "2")
              ]
        ]
  in
  let lang = L.empty () |> L.append syntax |> L.append syntax in
  Printf.printf "%s" @@ L.to_string lang;

  [%expect {|
    ident = 1+2
    ident = 1+2 |}]
