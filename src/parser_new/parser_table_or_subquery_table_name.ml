include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    let ident =
      M.bump_match (function
        | T.Tok_ident _ -> true
        | _ -> false)

    let parse () =
      let p =
        let alias = (M.bump_kw Kw.Kw_as <|> M.skip) *> ident <|> M.skip in
        let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
        ident *> alias
      in
      M.start_syntax K.N_table_or_subquery_table_name p

    let generate _ () = parse ()
  end :
    Intf.GEN)
