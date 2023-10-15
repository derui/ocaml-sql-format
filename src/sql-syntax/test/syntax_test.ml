open Types.Token
module R = Sql_syntax.Raw
module T = Sql_syntax.Trivia
module S = Sql_syntax.Syntax

type kind =
  | A
  | B

let%expect_test "syntax to string" =
  Printf.printf "%s" @@ S.to_string @@ S.make
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
