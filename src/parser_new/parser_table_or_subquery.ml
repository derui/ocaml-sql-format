include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    let ident =
      M.bump_match (function
        | T.Tok_ident _ -> true
        | _ -> false)

    let parse expr () =
      let alias = (M.bump_kw Kw.Kw_as <|> M.skip) *> ident <|> M.skip in
      let name_base =
        let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
        let name = ident *> alias in

        let fname =
          let expr_list =
            M.skip >>= expr >>= fun () -> M.many (M.bump_when Tok_comma >>= expr)
          in
          ident *> Wrapping.parens expr_list *> alias
        in
        fname <|> name
      in
      name_base

    let generate taker () =
      let expr = taker Parser_monad.Kind.N_expr in
      parse expr ()
  end :
    Intf.GEN)
