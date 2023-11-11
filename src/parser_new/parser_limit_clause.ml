include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val expr : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let* () = M.bump_kw Kw.Kw_limit in
          let* () = D.expr () in
          let offset = M.bump_kw Kw.Kw_offset >>= D.expr in
          let offset_comma = M.bump_when T.Tok_comma >>= D.expr in
          offset <|> offset_comma <|> M.skip
        in
        M.start_syntax K.N_limit_clause p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Sql_syntax.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
