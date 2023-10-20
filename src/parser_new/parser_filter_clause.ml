include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword

    let parse expr () =
      let* () =
        M.bump_kw Kw.Kw_filter *> M.bump_when T.Tok_lparen
        *> M.bump_kw Kw.Kw_where
      in
      let* () = expr () in
      M.bump_when T.Tok_rparen

    let generate taker () =
      let expr = taker Parser_monad.Kind.N_expr in
      parse expr ()
  end :
    Intf.GEN)
