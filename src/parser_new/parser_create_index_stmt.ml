include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val where_clause : Type.parser

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
          let* () = M.bump_kw Kw_create *> (M.bump_kw Kw_unique <|> M.skip) *> M.bump_kw Kw_index in
          let* () = M.bump_kw Kw_if *> M.bump_kw Kw_not *> M.bump_kw Kw_exists <|> M.skip in
          let* () = index_name *> M.bump_kw Kw_on *> ident in
          let* _ = Wrapping.parens @@ Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) @@ D.indexed_column () in
          D.where_clause () <|> M.skip
        in
        M.start_syntax K.N_create_index_stmt p
    end

    let generate taker () =
      let module P = P (struct
        let indexed_column = taker K.N_indexed_column

        let where_clause = taker K.N_where_clause
      end) in
      P.parse ()
  end :
    Intf.GEN)
