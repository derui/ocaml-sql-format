include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword

    let rec parse expr () = select expr

    and result_column expr () =
      let expr' = M.skip >>= expr in
      let star = M.bump_when T.Op_star in
      let table_name =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)
        *> M.bump_when T.Tok_period *> M.bump_when T.Op_star
      in
      let* () = expr' <|> star <|> table_name in
      M.return ()

    and select expr =
      let* () = M.bump_kw Kw.Kw_select in
      let* () = M.bump_kw Kw.Kw_distinct <|> M.bump_kw Kw.Kw_all <|> M.skip in
      let result_columns =
        let* () = M.skip >>= result_column expr in
        M.many (M.bump_when T.Tok_comma >>= result_column expr) *> M.skip
      in
      let* () = result_columns in
      M.skip

    let generate taker () =
      let expr = taker Parser_monad.Kind.N_expr in
      parse expr ()
  end :
    Intf.GEN)
