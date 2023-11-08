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

    let signed_number =
      (M.bump_when T.Op_plus <|> M.bump_when T.Op_minus <|> M.skip)
      *> M.bump_match (function
           | T.Tok_numeric _ -> true
           | _ -> false)

    let parse () =
      let* () = M.many1 ident *> M.skip in
      let one_arg = Wrapping.parens signed_number in
      let two_arg = Wrapping.parens (signed_number *> M.bump_when T.Tok_comma *> signed_number) in
      one_arg <|> two_arg <|> M.skip

    let generate _ = parse
  end :
    Intf.GEN)
