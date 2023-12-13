module M = Formatter_new.Monad
module S = Formatter_new.Support
module O = Formatter_new.Options
module L = Sql_syntax.Language
module R = Sql_syntax.Raw
module Tr = Sql_syntax.Trivia
module K = Sql_syntax.Kind
module T = Types.Token

let%expect_test "leaf" =
  let raw = R.make_leaf T.Op_eq in
  let m =
    S.leaf (function
      | R.Leaf { kind = K.L_eq; _ } as v -> Some v
      | _ -> None)
  in

  let no_m =
    S.leaf (function
      | R.Leaf { kind = K.L_ge; _ } as v -> Some v
      | _ -> None)
  in
  M.Run.run m O.default Fmt.stdout raw;
  M.Run.run no_m O.default Fmt.stdout raw;
  [%expect "="]

let%expect_test "keyword" =
  let raw = R.make_leaf ~leading:(Tr.leading [ T.Tok_space ]) (T.Tok_keyword ("By", Types.Keyword.Kw_by)) in
  let m = S.keyword Option.some in
  M.Run.run m O.default Fmt.stdout raw;
  M.Run.run m { O.default with O.keyword_case = `upper } Fmt.stdout raw;
  M.Run.run m { O.default with O.keyword_case = `as_is } Fmt.stdout raw;
  [%expect "byBYBy"]
