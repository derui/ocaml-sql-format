include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module K = Parser_monad.Kind
    module Kw = Types.Keyword

    module type Data = sig
      val expr : Type.parser
    end

    module P (D : Data) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p =
          let* () = M.bump_kw Kw.Kw_returning in
          let column =
            let expr' =
              let alias = (M.bump_kw Kw.Kw_as <|> M.skip) *> ident in
              (M.skip >>= D.expr) *> (alias <|> M.skip)
            in
            let star = M.bump_when T.Op_star in
            expr' <|> star
          in
          Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) column
        in
        M.start_syntax K.N_returning_clause p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker K.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)