module Tr = Sql_syntax.Trivia
module R = Sql_syntax.Raw
module S = Rewriter.Support
open Types.Token
open Sql_syntax.Kind

let%expect_test "spacing" =
  let raw = R.make_leaf Tok_qmark in
  let env = Rewriter.Env.make Rewriter.Options.default in
  let raw = S.space ~leading:3 ~trailing:2 env raw in

  Option.map R.to_string raw |> Option.value ~default:"" |> Printf.printf "|%s|";

  [%expect "|   ?  |"]

let%expect_test "newline with indent" =
  let raw = R.make_leaf Tok_qmark in
  let env = Rewriter.Env.make Rewriter.Options.default in
  let raw = S.newline env raw in

  Option.map R.to_string raw |> Option.value ~default:"" |> Printf.printf "|%s|";

  [%expect "\n    |\n        ?|"]

let%test_unit "when leaf is not match" =
  let raw = R.make_leaf Tok_qmark in
  let env = Rewriter.Env.make Rewriter.Options.default in
  let raw = S.when_leaf L_eq S.newline env raw in

  let ret = Option.map R.to_string raw in
  assert (Option.is_none ret)

let%expect_test "when leaf is match" =
  let raw = R.make_leaf Tok_qmark in
  let env = Rewriter.Env.make Rewriter.Options.default in
  let raw = S.when_leaf L_qmark S.newline env raw in

  Option.map R.to_string raw |> Option.value ~default:"" |> Printf.printf "|%s|";

  [%expect "\n    |\n        ?|"]

let%expect_test "map layouts" =
  let raw = R.make_node N_expr ~layouts:[ R.make_leaf Tok_qmark; R.make_leaf (Tok_ident "ident") ] in
  let env = Rewriter.Env.make Rewriter.Options.default in
  let raw = S.map ~rewriter:S.newline env raw in

  List.iter (fun v -> R.to_string v |> Printf.printf "|%s|") raw;

  [%expect "\n    |\n        ?||\n        ident|"]
