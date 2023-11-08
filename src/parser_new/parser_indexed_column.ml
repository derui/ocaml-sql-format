include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
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
          let* () = ident <|> D.expr () in
          let* () = M.bump_kw Kw_collate *> ident <|> M.skip in
          M.bump_kw Kw_asc <|> M.bump_kw Kw_desc <|> M.skip
        in
        M.start_syntax K.N_indexed_column p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker K.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
