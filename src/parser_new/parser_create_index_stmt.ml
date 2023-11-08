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

      val indexed_column : Type.parser
    end

    module P (D : Data) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let index_name =
        let schema = ident *> M.bump_when T.Tok_period in
        (schema <|> M.skip) *> ident

      let parse () =
        let p =
          let* () = M.bump_kw Kw_create *> (M.bump_kw Kw_unique <|> M.skip) in
          let* () = M.bump_kw Kw_if *> M.bump_kw Kw_not *> M.bump_kw Kw_exists <|> M.skip in
          let* () = index_name *> M.bump_kw Kw_on *> ident in
          let* _ = Wrapping.parens @@ Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) @@ D.indexed_column () in
          M.bump_kw Kw_where >>= D.expr <|> M.skip
        in
        M.start_syntax K.N_create_index_stmt p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker K.N_expr

        let indexed_column = taker K.N_indexed_column
      end) in
      P.parse ()
  end :
    Intf.GEN)
