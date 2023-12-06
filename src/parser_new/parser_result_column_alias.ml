include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module T = Types.Token
    module K = Sql_syntax.Kind
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
          let alias = (M.bump_kw Kw.Kw_as <|> M.skip) *> ident in
          (M.skip >>= D.expr) *> (alias <|> M.skip)
        in
        M.start_syntax K.N_result_column_alias p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Sql_syntax.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
