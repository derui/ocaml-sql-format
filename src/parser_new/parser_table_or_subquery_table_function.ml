include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type D = sig
      val expr : Type.parser
    end

    module P (D : D) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p =
          let alias = (M.bump_kw Kw.Kw_as <|> M.skip) *> ident <|> M.skip in
          let expr_list = M.skip >>= D.expr >>= fun () -> M.many (M.bump_when Tok_comma >>= D.expr) in
          ident *> Wrapping.parens expr_list *> alias
        in
        M.start_syntax K.N_table_or_subquery_table_function p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Sql_syntax.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
