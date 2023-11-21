open Types.Token
module R = Sql_syntax.Raw
module T = Sql_syntax.Trivia
module L = Sql_syntax.Language
open Sql_syntax.Kind

let%test_unit "append syntax to language" =
  let lang = L.empty () in
  assert (L.to_string lang = "")

let%expect_test "language to string" =
  let syntax =
    R.make_node N_expr
      ~layouts:
        [ R.make_leaf ~leading:(T.leading [ Tok_newline ]) ~trailing:(T.trailing [ Tok_space ]) (Tok_ident "ident")
        ; R.make_leaf ~trailing:(T.trailing [ Tok_space ]) Op_eq
        ; R.make_node N_expr
            ~layouts:[ R.make_leaf (Tok_numeric "1"); R.make_leaf Op_plus; R.make_leaf (Tok_numeric "2") ]
        ]
  in
  let lang = L.empty () |> L.append syntax |> L.append syntax in
  Printf.printf "%s" @@ L.to_string lang;

  [%expect {|
    ident = 1+2
    ident = 1+2 |}]

let%expect_test "walk raw in language" =
  let syntax =
    R.make_node N_expr
      ~layouts:
        [ R.make_leaf ~leading:(T.leading [ Tok_newline ]) ~trailing:(T.trailing [ Tok_space ]) (Tok_ident "ident")
        ; R.make_leaf ~trailing:(T.trailing [ Tok_space ]) Op_eq
        ; R.make_node N_expr
            ~layouts:[ R.make_leaf (Tok_numeric "1"); R.make_leaf Op_plus; R.make_leaf (Tok_numeric "2") ]
        ]
  in
  let lang = L.empty () |> L.append syntax |> L.append syntax in
  let v = ref [] in
  L.walk
    ~f:(fun r ->
      v := r :: !v;
      Some ())
    lang;

  List.iter (fun v -> print_endline @@ R.to_string v) !v;

  [%expect
    {|
    ident
    =
    1
    +
    2
    1+2

    ident = 1+2

    ident
    =
    1
    +
    2
    1+2

    ident = 1+2 |}]

let%expect_test "do not dig into if function returned None" =
  let syntax =
    R.make_node N_expr
      ~layouts:
        [ R.make_leaf ~leading:(T.leading [ Tok_newline ]) ~trailing:(T.trailing [ Tok_space ]) (Tok_ident "ident")
        ; R.make_leaf ~trailing:(T.trailing [ Tok_space ]) Op_eq
        ; R.make_node N_expr
            ~layouts:[ R.make_leaf (Tok_numeric "1"); R.make_leaf Op_plus; R.make_leaf (Tok_numeric "2") ]
        ]
  in
  let lang = L.empty () |> L.append syntax |> L.append syntax in
  let v = ref [] in
  L.walk
    ~f:(fun r ->
      v := r :: !v;
      None)
    lang;

  List.iter (fun v -> print_endline @@ R.to_string v) !v;

  [%expect {|
    ident = 1+2

    ident = 1+2 |}]
