include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module K = Parser_monad.Kind
    module Kw = Types.Keyword

    module type Data = sig
      val from_clause : Type.parser

      val where_clause : Type.parser

      val group_by_clause : Type.parser

      val window_clause : Type.parser

      val having_clause : Type.parser

      val result_column : Type.parser

      val expr : Type.parser
    end

    module P (D : Data) = struct
      let select () =
        let* () = M.bump_kw Kw.Kw_select in
        let* () = M.bump_kw Kw.Kw_distinct <|> M.bump_kw Kw.Kw_all <|> M.skip in
        let result_columns =
          let* _ = Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) (M.skip >>= D.result_column) in
          M.return ()
        in
        let* () = result_columns in
        let* () = D.from_clause () <|> M.skip in
        let* () = D.where_clause () <|> M.skip in
        let* () = D.group_by_clause () <|> M.skip in
        let* () = D.having_clause () <|> M.skip in
        let* () = D.window_clause () <|> M.skip in
        M.return ()

      let values () =
        let* () = M.bump_kw Kw.Kw_values in
        let sep = M.bump_when T.Tok_comma in
        let values = Wrapping.parens (Subparser.nonempty_list ~sep (M.skip >>= D.expr)) in
        let* _ = Subparser.nonempty_list ~sep values in
        M.return ()

      let parse () =
        let p = select () <|> values () in
        M.start_syntax K.N_select_core p
    end

    let generate taker () =
      let module P = P (struct
        let from_clause = taker Parser_monad.Kind.N_from_clause

        let group_by_clause = taker Parser_monad.Kind.N_group_by_clause

        let having_clause = taker Parser_monad.Kind.N_having_clause

        let where_clause = taker Parser_monad.Kind.N_where_clause

        let window_clause = taker Parser_monad.Kind.N_window_clause

        let result_column = taker Parser_monad.Kind.N_result_column

        let expr = taker Parser_monad.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
