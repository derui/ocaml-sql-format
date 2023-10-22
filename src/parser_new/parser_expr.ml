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
    end

    module V (S : Param) = struct
      let literal_value = S.literal_value

      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let name =
        let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
        let* () = ident *> M.bump_when T.Tok_period <|> M.skip in
        ident

      let bind_parameter = M.bump_when T.Tok_qmark

      let binary_operator =
        M.bump_when T.Op_amp <|> M.bump_when T.Op_eq <|> M.bump_when T.Op_eq2
        <|> M.bump_when T.Op_plus <|> M.bump_when T.Op_minus
        <|> M.bump_when T.Op_star <|> M.bump_when T.Op_slash
        <|> M.bump_when T.Op_pipe <|> M.bump_when T.Op_lshift
        <|> M.bump_when T.Op_rshift <|> M.bump_when T.Op_ge
        <|> M.bump_when T.Op_gt <|> M.bump_when T.Op_le <|> M.bump_when T.Op_lt
        <|> M.bump_when T.Op_ne <|> M.bump_when T.Op_ne2
        <|> M.bump_when T.Op_extract <|> M.bump_when T.Op_extract_2

      let rec expr () =
        let function_ =
          let* () = ident *> M.bump_when T.Tok_lparen in
          let exprs =
            let* () = M.bump_kw Kw.Kw_distinct <|> M.skip in
            let* () = expr () in
            M.many (M.bump_when T.Tok_comma *> expr ()) *> M.skip
          in
          let* () = exprs <|> M.bump_when T.Op_star <|> M.skip in
          let* () = M.bump_when Tok_rparen in
          S.filter_clause () <|> M.skip
        in
        let* () =
          unary () <|> collate () <|> wrap_parens () <|> cast () <|> function_
          <|> like () <|> literal_value () <|> bind_parameter <|> name
        in
        binary_operator >>= expr <|> M.skip

      and wrap_parens () =
        let p =
          let* () = M.bump_when T.Tok_lparen in
          let* () = expr () in
          let* () = M.many (M.bump_when T.Tok_comma >>= expr) *> M.skip in
          M.bump_when T.Tok_rparen
        in
        M.start_syntax K.N_expr_wrap p

      and unary () =
        let op =
          M.bump_when T.Op_tilda <|> M.bump_when T.Op_plus
          <|> M.bump_when T.Op_minus <|> M.bump_kw Kw_not
        in
        M.start_syntax K.N_expr_unary @@ (op *> (M.skip >>= expr))

      and cast () =
        let* () = M.bump_kw Kw.Kw_cast in
        let p =
          let* () = expr () in
          M.bump_kw Kw.Kw_as >>= S.type_name
        in
        Wrapping.parens p

      and collate () =
        M.start_syntax K.N_expr_collate
        @@ ((M.skip >>= expr) *> M.bump_kw Kw.Kw_collate *> ident)

      and like () =
        let p =
          let* () = M.skip >>= expr in
          let* () = M.bump_kw Kw.Kw_not <|> M.skip in
          let* () = M.bump_kw Kw.Kw_like >>= expr in
          M.bump_kw Kw.Kw_escape >>= expr <|> M.skip
        in
        M.start_syntax K.N_expr_like p
    end

    let generate v () =
      let literal_value = Parser_literal_value.generate v in
      let filter_clause = v Parser_monad.Kind.N_filter_clause in
      let type_name = v Parser_monad.Kind.N_type_name in
      let module V = V (struct
        let literal_value = literal_value

        let filter_clause = filter_clause

        let type_name = type_name
      end) in
      V.expr ()
  end :
    Intf.GEN)
