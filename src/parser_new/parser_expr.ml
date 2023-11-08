include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Parser_monad.Kind

    module type Param = sig
      val literal_value : Type.parser

      val filter_clause : Type.parser

      val type_name : Type.parser

      val over_clause : Type.parser

      val select_stmt : Type.parser
    end

    module V (S : Param) = struct
      let literal_value () = M.start_syntax K.N_expr_literal @@ (M.skip >>= S.literal_value)

      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let name =
        let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
        let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
        ident

      let bind_parameter = M.bump_when T.Tok_qmark

      let rec expr () =
        let* () = non_binary_expr () in
        binary_operator () <|> M.skip

      and non_binary_expr () =
        unary () <|> collate () <|> wrap_parens () <|> cast () <|> exists () <|> function_ () <|> case ()
        <|> literal_value () <|> bind_parameter <|> name

      and binary_operator () =
        let as_op op = M.start_syntax (K.N_expr_binary_op (`op op)) (M.bump_when op >>= expr) in
        let kw_as_op kw = M.start_syntax (K.N_expr_binary_op (`kw kw)) (M.bump_kw kw >>= expr) in
        let tier_1 = as_op Op_extract <|> as_op Op_extract_2 <|> as_op Op_concat in
        let tier_2 = as_op Op_star <|> as_op Op_slash <|> as_op Op_modulo in
        let tier_3 = as_op Op_plus <|> as_op Op_minus in
        let tier_4 = as_op Op_amp <|> as_op Op_pipe <|> as_op Op_rshift <|> as_op Op_lshift in
        let tier_5 = as_op Op_gt <|> as_op Op_ge <|> as_op Op_le <|> as_op Op_lt in
        let tier_6 =
          as_op Op_eq <|> as_op Op_eq2 <|> as_op Op_ne <|> as_op Op_ne2 <|> is () <|> in_ () <|> between () <|> glob ()
          <|> like () <|> regexp () <|> match_ ()
        in
        let tier_7 = kw_as_op Kw_and in
        let tier_8 = kw_as_op Kw_or in
        tier_1 <|> tier_2 <|> tier_3 <|> tier_4 <|> tier_5 <|> tier_6 <|> tier_7 <|> tier_8

      and function_ () =
        let* () = ident *> M.bump_when T.Tok_lparen in
        let exprs =
          let* () = M.bump_kw Kw.Kw_distinct <|> M.skip in
          let* () = expr () in
          M.many (M.bump_when T.Tok_comma *> expr ()) *> M.skip
        in
        let* () = exprs <|> M.bump_when T.Op_star <|> M.skip in
        let* () = M.bump_when Tok_rparen in
        let* () = S.filter_clause () <|> M.skip in
        S.over_clause () <|> M.skip

      and wrap_parens () =
        let p =
          let e =
            let* () = M.skip >>= expr in
            M.many (M.bump_when T.Tok_comma >>= expr) *> M.skip
          in
          Wrapping.parens e
        in
        M.start_syntax K.N_expr_wrap p

      and unary () =
        let op = M.bump_when T.Op_tilda <|> M.bump_when T.Op_plus <|> M.bump_when T.Op_minus <|> M.bump_kw Kw_not in
        M.start_syntax K.N_expr_unary @@ (op >>= expr)

      and cast () =
        let* () = M.bump_kw Kw.Kw_cast in
        let p =
          let* () = expr () in
          M.bump_kw Kw.Kw_as >>= S.type_name
        in
        Wrapping.parens p

      and collate () = M.start_syntax K.N_expr_collate @@ ((M.skip >>= expr) *> M.bump_kw Kw.Kw_collate *> ident)

      and like () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_like >>= expr in
          M.bump_kw Kw.Kw_escape >>= expr <|> M.skip
        in
        M.start_syntax K.N_expr_like p

      and glob () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_glob >>= expr
        in
        M.start_syntax K.N_expr_glob p

      and regexp () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_regexp >>= expr
        in
        M.start_syntax K.N_expr_regexp p

      and match_ () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_match >>= expr
        in
        M.start_syntax K.N_expr_match p

      and is () =
        let p =
          let* () = M.bump_kw Kw.Kw_is in
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_distinct *> M.bump_kw Kw.Kw_from <|> M.skip in
          expr ()
        in
        M.start_syntax K.N_expr_is p

      and between () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          M.bump_kw Kw.Kw_between >>= non_binary_expr >>= fun () -> M.bump_kw Kw.Kw_and >>= non_binary_expr
        in
        M.start_syntax K.N_expr_between p

      and in_ () =
        let p =
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let schema = ident *> M.bump_when T.Tok_period <|> M.skip in
          let list =
            let* () = M.skip >>= expr in
            M.many (M.bump_when T.Tok_comma >>= expr)
          in
          let name = schema *> ident
          and table_function_ =
            schema *> name *> (M.bump_when Tok_lparen *> M.bump_when Tok_rparen <|> Wrapping.parens list)
          in
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
              let* () = M.bump_kw Kw.Kw_when >>= expr in
              M.bump_kw Kw.Kw_then >>= expr
            in
            M.start_syntax K.N_expr_when p
          in
          let* () = M.bump_kw Kw.Kw_case in
          let* () = M.skip >>= expr <|> M.skip in
          let* _ = M.many1 when_ in
          let* () = M.bump_kw Kw.Kw_else >>= expr <|> M.skip in
          M.bump_kw Kw.Kw_end
        in
        M.start_syntax K.N_expr_case p
    end

    let generate v () =
      let literal_value = Parser_literal_value.generate v in
      let filter_clause = v Parser_monad.Kind.N_filter_clause in
      let module V = V (struct
        let literal_value = literal_value

        let filter_clause = filter_clause

        let type_name = v Parser_monad.Kind.N_type_name

        let over_clause = v Parser_monad.Kind.N_over_clause

        let select_stmt = v Parser_monad.Kind.N_select_stmt
      end) in
      V.expr ()
  end :
    Intf.GEN)
