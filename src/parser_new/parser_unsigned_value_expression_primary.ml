include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val expr : Type.parser

      val over_clause : Type.parser

      val filter_clause : Type.parser

      val order_by_clause : Type.parser

      val select_stmt : Type.parser
    end

    module V (S : Param) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let name =
        let p =
          let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
          let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
          ident
        in
        M.start_syntax K.N_uvep_ident p

      let bind_parameter = M.start_syntax N_uvep_parameter_reference @@ M.bump_when T.Tok_qmark

      let subquery () =
        let p = Wrapping.parens (M.skip >>= S.select_stmt) in
        M.start_syntax N_uvep_subquery p

      let nested_expression () =
        let expr = Subparser.nonempty_list ~sep:(M.bump_when Tok_comma) (M.skip >>= S.expr) in
        let p = Wrapping.parens expr in
        M.start_syntax N_uvep_nested_expression p

      let case_expression () =
        let p =
          let case =
            let p =
              let* () = M.bump_kw Kw.Kw_case in
              M.skip >>= S.expr <|> M.skip
            in
            M.start_syntax K.N_expr_case_case p
          in
          let when_ =
            let p =
              let* () = M.bump_kw Kw.Kw_when >>= S.expr in
              M.bump_kw Kw.Kw_then >>= S.expr
            in
            M.start_syntax K.N_expr_case_when p
          in
          let else_ =
            let p = M.bump_kw Kw.Kw_else >>= S.expr <|> M.skip in
            M.start_syntax K.N_expr_case_else p
          in
          let* _ = case in
          let* _ = M.many1 when_ in
          let* _ = else_ in
          M.bump_kw Kw.Kw_end
        in
        M.start_syntax K.N_uvep_case_expression p

      let function_ () =
        let p =
          let fname =
            M.bump_kw Kw_count <|> M.bump_kw Kw_sum <|> M.bump_kw Kw_min <|> M.bump_kw Kw_max <|> M.bump_kw Kw_avg
            <|> M.bump_kw Kw_every <|> M.bump_kw Kw_some <|> M.bump_kw Kw_any <|> ident
          in
          let* () = fname *> M.bump_when T.Tok_lparen in
          let exprs =
            let* () = M.bump_kw Kw.Kw_distinct <|> M.skip in
            let* _ = Subparser.nonempty_list ~sep:(M.bump_when Tok_comma) (S.expr ()) in
            S.order_by_clause () <|> M.skip
          in
          let* () = exprs <|> M.bump_when T.Op_star <|> M.skip in
          let* () = M.bump_when Tok_rparen in
          let* () = S.filter_clause () <|> M.skip in
          S.over_clause () <|> M.skip
        in
        M.start_syntax K.N_uvep_function p

      let parse () =
        let p =
          subquery () <|> nested_expression () <|> case_expression () <|> function_ () <|> name <|> bind_parameter
        in
        M.start_syntax K.N_unsigned_value_expression_primary p
    end

    let generate v () =
      let module V = V (struct
        let expr = v Sql_syntax.Kind.N_expr

        let order_by_clause = v Sql_syntax.Kind.N_order_by_clause

        let filter_clause = v Sql_syntax.Kind.N_filter_clause

        let over_clause = v Sql_syntax.Kind.N_over_clause

        let select_stmt = v Sql_syntax.Kind.N_select_stmt
      end) in
      V.parse ()
  end :
    Intf.GEN)
