open Types.Token
module R = Sql_syntax.Raw
module T = Sql_syntax.Trivia

type kind =
  | A
  | B

let%test_unit "make raw data" =
  R.make_node B
    ~layouts:
      [ R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing [])
          ~token:Tok_colon
      ]
  |> ignore;
  assert true

let%expect_test "raw to string" =
  Printf.printf "%s" @@ R.to_string
  @@ R.make_node B
       ~layouts:
         [ R.make_leaf A ~leading:(T.leading [])
             ~trailing:(T.trailing [ Tok_space ]) ~token:(Tok_ident "ident")
         ; R.make_leaf A ~leading:(T.leading [])
             ~trailing:(T.trailing [ Tok_space ]) ~token:Op_eq
         ; R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing [])
             ~token:(Tok_string "foo")
         ];

  [%expect {|
    ident = foo |}]

let%expect_test "node to string" =
  Printf.printf "%s" @@ R.to_string
  @@ R.make_node B
       ~layouts:
         [ R.make_leaf A ~leading:(T.leading [])
             ~trailing:(T.trailing [ Tok_space ]) ~token:(Tok_ident "ident")
         ; R.make_leaf A ~leading:(T.leading [])
             ~trailing:(T.trailing [ Tok_space ]) ~token:Op_eq
         ; R.make_node B
             ~layouts:
               [ R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing [])
                   ~token:(Tok_numeric "1")
               ; R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing [])
                   ~token:Op_plus
               ; R.make_leaf A ~leading:(T.leading []) ~trailing:(T.trailing [])
                   ~token:(Tok_numeric "2")
               ]
         ];

  [%expect {|
    ident = 1+2 |}]
