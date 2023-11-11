module M = Parser_monad.Monad
open M.Let_syntax
open M.Syntax
module T = Types.Token

(** [nonempty_list ~sep parser] parse [m(sep m)*] for developer convinience *)
let nonempty_list ~sep m =
  let* _ = m in
  M.many (sep *> m)

(** [list ~sep parser] parse [(m sep)*m?] for developer convinience *)
let list ~sep m = M.many (m *> sep) *> (m <|> M.skip)
