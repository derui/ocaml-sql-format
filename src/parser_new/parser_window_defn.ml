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

      val order_by_clause : Type.parser

      val frame_spec : Type.parser
    end

    module P (D : Data) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let window_defn =
        let* () = ident <|> M.skip in
        let* () =
          let partition =
            let* () = M.bump_kw Kw.Kw_partition *> M.bump_kw Kw.Kw_by in
            let* _ = Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) (M.skip >>= D.expr) in
            M.return ()
          in
          partition <|> M.skip
        in
        let* () = D.order_by_clause () <|> M.skip in
        let* () = D.frame_spec () <|> M.skip in
        M.return ()

      let parse () =
        let p = Wrapping.parens window_defn in
        M.start_syntax K.N_window_defn p
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Sql_syntax.Kind.N_expr

        let order_by_clause = taker Sql_syntax.Kind.N_order_by_clause

        let frame_spec = taker Sql_syntax.Kind.N_frame_spec
      end) in
      P.parse ()
  end :
    Intf.GEN)
