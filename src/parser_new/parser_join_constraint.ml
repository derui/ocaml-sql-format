include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val expr : Type.parser
    end

    module P (D : Data) = struct
      let ident () =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p =
          let on_ = M.bump_kw Kw.Kw_on >>= D.expr in
          let using =
            M.bump_kw Kw.Kw_using *> Wrapping.parens (Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) (ident ()))
          in
          on_ <|> using <|> M.skip
        in
        M.start_syntax K.N_join_constraint p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Sql_syntax.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
