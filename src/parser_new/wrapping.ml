module M = Parser_monad.Monad
open M.Let_syntax
module T = Types.Token

(** [parens parser] wrap [parser] with [()] *)
let parens m =
  let* () = M.bump_when T.Tok_lparen in
  let* _ = m in
  M.bump_when T.Tok_rparen
