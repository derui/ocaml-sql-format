open Types.Token
module R = Sql_syntax.Raw
module T = Sql_syntax.Trivia
open Sql_syntax.Kind

let%test_unit "make raw data" =
  let node = R.make_node N_expr ~layouts:[ R.make_leaf Tok_colon ] in
  assert (R.match' (Types.Token.equal Tok_colon) node = false)

let%test_unit "make leaf data" =
  let node = R.make_leaf Tok_colon in
  assert (R.match' (Types.Token.equal Tok_colon) node = true);
  assert (R.match' (Types.Token.equal Op_eq) node = false)

let%test_unit "replace leaf data" =
  let leaf = R.make_leaf Tok_colon in
  let leaf' = R.replace (fun _ -> Op_eq) leaf in
  let node = R.make_node N_expr ~layouts:[] in
  let node' = R.replace (fun _ -> Op_eq) node in
  assert (R.match' (Types.Token.equal Op_eq) leaf' = true);
  assert (R.match' (Types.Token.equal Op_eq) node' = false)

let%expect_test "replace layouts" =
  let node = R.make_node N_expr ~layouts:[] in
  let node' = R.replace_layouts [ R.make_leaf Tok_colon ] node in
  Printf.printf "%s" @@ R.to_string node';

  [%expect {| : |}]

let%test_unit "replace trivia" =
  let leaf = R.make_leaf Tok_dollar in
  let leaf' =
    R.replace_trivia
      ~leading:(fun _ -> T.leading [ Tok_space ])
      ~trailing:(fun _ -> T.trailing [ Tok_space; Tok_space ])
      leaf
  in
  assert (" $  " = R.to_string leaf')

let%expect_test "raw to string" =
  Printf.printf "%s" @@ R.to_string
  @@ R.make_node N_expr
       ~layouts:
         [ R.make_leaf ~trailing:(T.trailing [ Tok_space ]) (Tok_ident "ident")
         ; R.make_leaf ~trailing:(T.trailing [ Tok_space ]) Op_eq
         ; R.make_leaf (Tok_string "foo")
         ];

  [%expect {|
    ident = foo |}]

let%expect_test "node to string" =
  Printf.printf "%s" @@ R.to_string
  @@ R.make_node N_expr
       ~layouts:
         [ R.make_leaf ~trailing:(T.trailing [ Tok_space ]) (Tok_ident "ident")
         ; R.make_leaf ~trailing:(T.trailing [ Tok_space ]) Op_eq
         ; R.make_node N_expr
             ~layouts:[ R.make_leaf (Tok_numeric "1"); R.make_leaf Op_plus; R.make_leaf (Tok_numeric "2") ]
         ];

  [%expect {|
    ident = 1+2 |}]
