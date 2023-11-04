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
      let parse () =
        let p =
          let* () = D.expr () in
          let* () = M.bump_kw Kw.Kw_asc <|> M.bump_kw Kw.Kw_desc <|> M.skip in
          let* () =
            let nulls_first = M.bump_kw Kw.Kw_nulls *> M.bump_kw Kw.Kw_first in
            let nulls_last = M.bump_kw Kw.Kw_nulls *> M.bump_kw Kw.Kw_last in
            nulls_first <|> nulls_last <|> M.skip
          in
          M.return ()
        in
        M.start_syntax K.N_ordering_term p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Parser_monad.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
