open Types.Token
module R = Sql_syntax.Raw
module T = Sql_syntax.Trivia
module L = Sql_syntax.Language
open Sql_syntax.Kind
open Rewriter.Monad

let eval m raw =
  match Runner.run m ~resolver:(fun _ -> R.make_leaf Op_eq |> return) ~options:Rewriter.Options.default raw with
  | Ok v -> v
  | Error e -> failwith e

let%test_unit "append spacer" =
  let m = leaf L_ge >>= Re.spacer ~trailing:2 in
  let v = eval m (R.make_node N_expr ~layouts:[ R.make_leaf Op_ge ]) |> R.to_string in
  assert (v = " >=  ")

let%test_unit "append newline" =
  let m = leaf L_ge >>= Re.newline in
  let v = eval m (R.make_node N_expr ~layouts:[ R.make_leaf Op_ge ]) |> R.to_string in
  assert (v = "\n>=")

let%test_unit "newline with indent" =
  let m = Re.indent_in 2 >>= fun _ -> leaf L_ge >>= Re.newline in
  let v = eval m (R.make_node N_expr ~layouts:[ R.make_leaf Op_ge ]) |> R.to_string in
  assert (v = "\n  >=")