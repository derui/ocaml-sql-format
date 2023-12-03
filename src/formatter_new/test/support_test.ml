module M = Formatter_new.Monad
module S = Formatter_new.Support
module O = Formatter_new.Options
module L = Sql_syntax.Language
module R = Sql_syntax.Raw
module K = Sql_syntax.Kind
module T = Types.Token

let%expect_test "leaf" =
  let raw = R.make_leaf T.Op_eq in
  let m =
    S.leaf
      (function
        | R.Leaf { kind = K.L_eq; _ } as v -> Some v
        | _ -> None)
      raw
  in
  let no_m =
    S.leaf
      (function
        | R.Leaf { kind = K.L_ge; _ } as v -> Some v
        | _ -> None)
      raw
  in
  M.Run.run m O.default Fmt.stdout raw;
  M.Run.run no_m O.default Fmt.stdout raw;
  [%expect "="]
