include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword

    let ident =
      M.bump_match (function
        | T.Tok_ident _ -> true
        | _ -> false)

    let name =
      let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
      let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
      ident

    let rec unary =
      M.bump_when T.Op_tilda <|> M.bump_when T.Op_plus
      <|> M.bump_when T.Op_minus <|> M.bump_kw Kw_not

    and parse literal_value () =
      literal_value <|> M.bump_when T.Tok_qmark <|> name
      <|> (unary >>= parse literal_value)

    let generate v =
      let literal_value = Parser_literal_value.generate v in
      parse literal_value ()
  end :
    Intf.GEN)
