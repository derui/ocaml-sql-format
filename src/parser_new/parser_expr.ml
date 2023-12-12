include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val literal_value : Type.parser

      val filter_clause : Type.parser

      val type_name : Type.parser

      val over_clause : Type.parser

      val order_by_clause : Type.parser

      val select_stmt : Type.parser
    end

    module V (S : Param) = struct
      let literal_value () = M.start_syntax N_expr_literal @@ S.literal_value ()

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
        M.start_syntax K.N_expr_name p

      let bind_parameter = M.start_syntax N_expr_bind_parameter @@ M.bump_when T.Tok_qmark

      let rec expr () = M.start_syntax K.N_expr (expr' ())

      and expr' () =
        let* () = non_binary_expr () in
        binary_operator () <|> M.skip

      and non_binary_expr () =
        unary () <|> collate () <|> wrap_parens () <|> cast () <|> exists () <|> function_ () <|> case ()
        <|> literal_value () <|> bind_parameter <|> name

      and binary_operator () =
        let as_op op = M.start_syntax K.N_expr_binary_op (M.bump_when op >>= expr') in
        let as_logical_op kw = M.start_syntax K.N_expr_logical_op (M.bump_kw kw >>= expr') in
        let tier_1 = as_op Op_extract <|> as_op Op_extract_2 <|> as_op Op_concat in
        let tier_2 = as_op Op_star <|> as_op Op_slash <|> as_op Op_modulo in
        let tier_3 = as_op Op_plus <|> as_op Op_minus in
        let tier_4 = as_op Op_amp <|> as_op Op_pipe <|> as_op Op_rshift <|> as_op Op_lshift in
        let tier_5 = as_op Op_gt <|> as_op Op_ge <|> as_op Op_le <|> as_op Op_lt in
        let tier_6 =
          as_op Op_eq <|> as_op Op_eq2 <|> as_op Op_ne <|> as_op Op_ne2 <|> is () <|> in_ () <|> between () <|> glob ()
          <|> like () <|> regexp () <|> match_ ()
        in
        let tier_7 = as_logical_op Kw_and in
        let tier_8 = as_logical_op Kw_or in
        tier_1 <|> tier_2 <|> tier_3 <|> tier_4 <|> tier_5 <|> tier_6 <|> tier_7 <|> tier_8

      and function_ () =
        let p =
          let* () = ident *> M.bump_when T.Tok_lparen in
          let exprs =
            let* () = M.bump_kw Kw.Kw_distinct <|> M.skip in
            let* () = expr' () in
            let* _ = M.many (M.bump_when T.Tok_comma *> expr' ()) in
            S.order_by_clause () <|> M.skip
          in
          let* () = exprs <|> M.bump_when T.Op_star <|> M.skip in
          let* () = M.bump_when Tok_rparen in
          let* () = S.filter_clause () <|> M.skip in
          S.over_clause () <|> M.skip
        in
        M.start_syntax K.N_expr_function p

      and wrap_parens () =
        let p =
          let e =
            let* () = M.skip >>= expr' in
            M.many (M.bump_when T.Tok_comma >>= expr') *> M.skip
          in
          Wrapping.parens e
        in
        M.start_syntax K.N_expr_wrap p

      and unary () =
        let op = M.bump_when T.Op_tilde <|> M.bump_when T.Op_plus <|> M.bump_when T.Op_minus <|> M.bump_kw Kw_not in
        M.start_syntax K.N_expr_unary @@ (op >>= expr')

      and cast () =
        let p =
          let* () = M.bump_kw Kw.Kw_cast in
          let wrapped =
            let* () = expr' () in
            M.bump_kw Kw.Kw_as >>= S.type_name
          in
          Wrapping.parens wrapped
        in
        M.start_syntax K.N_expr_cast p

      and collate () =
        let p = (M.skip >>= expr') *> M.bump_kw Kw.Kw_collate *> ident in
        M.start_syntax K.N_expr_collate p

      and like () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_like >>= expr' in
          M.bump_kw Kw.Kw_escape >>= expr' <|> M.skip
        in
        M.start_syntax K.N_expr_like p

      and glob () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_glob >>= expr'
        in
        M.start_syntax K.N_expr_glob p

      and regexp () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_regexp >>= expr'
        in
        M.start_syntax K.N_expr_regexp p

      and match_ () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_match >>= expr'
        in
        M.start_syntax K.N_expr_match p

      and is () =
        let p =
          let* () = M.bump_kw Kw.Kw_is in
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_distinct *> M.bump_kw Kw.Kw_from <|> M.skip in
          expr' ()
        in
        M.start_syntax K.N_expr_is p

      and between () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_between >>= between_predicand >>= fun () -> M.bump_kw Kw.Kw_and >>= between_predicand
        in
        M.start_syntax K.N_expr_between p

      and between_predicand () =
        let p =
          (* TODO split expr into boolean expression and value expression  *)
          M.start_syntax K.N_expr @@ non_binary_expr ()
        in
        M.start_syntax K.N_expr_between_predicand p

      and in_ () =
        let p =
          let schema = ident *> M.bump_when T.Tok_period <|> M.skip in
          let list =
            let* () = M.skip >>= expr' in
            M.many (M.bump_when T.Tok_comma >>= expr')
          in
          let name = schema *> ident
          and table_function_ =
            schema *> name *> (M.bump_when Tok_lparen *> M.bump_when Tok_rparen <|> Wrapping.parens list)
          in
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_in in
          table_function_ <|> name <|> Wrapping.parens list
        in
        M.start_syntax K.N_expr_in p

      and exists () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_exists in
          Wrapping.parens (S.select_stmt ())
        in
        M.start_syntax K.N_expr_exists p

      and case () =
        let p =
          let when_ =
            let p =
              let* () = M.bump_kw Kw.Kw_when >>= expr' in
              M.bump_kw Kw.Kw_then >>= expr'
            in
            M.start_syntax K.N_expr_when p
          in
          let* () = M.bump_kw Kw.Kw_case in
          let* () = M.skip >>= expr' <|> M.skip in
          let* _ = M.many1 when_ in
          let* () = M.bump_kw Kw.Kw_else >>= expr' <|> M.skip in
          M.bump_kw Kw.Kw_end
        in
        M.start_syntax K.N_expr_case p
    end

    let generate v () =
      let literal_value = Parser_literal_value.generate v in
      let filter_clause = v Sql_syntax.Kind.N_filter_clause in
      let module V = V (struct
        let literal_value = literal_value

        let filter_clause = filter_clause

        let type_name = v Sql_syntax.Kind.N_type_name

        let over_clause = v Sql_syntax.Kind.N_over_clause

        let order_by_clause = v Sql_syntax.Kind.N_order_by_clause

        let select_stmt = v Sql_syntax.Kind.N_select_stmt
      end) in
      V.expr ()
  end :
    Intf.GEN)
