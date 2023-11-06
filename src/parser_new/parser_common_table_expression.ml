include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val select_stmt : Type.parser
    end

    module P (D : Data) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p =
          let* () = ident in
          let columns =
            Wrapping.parens
              (Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) ident)
          in
          let* _ = columns <|> M.skip in
          let* () = M.bump_kw Kw.Kw_as in
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_materialized <|> M.skip in
          Wrapping.parens (D.select_stmt ())
        in
        M.start_syntax K.N_common_table_expression p
    end

    let generate taker () =
      let module P = P (struct
        let select_stmt = taker Parser_monad.Kind.N_select_stmt
      end) in
      P.parse ()
  end :
    Intf.GEN)
