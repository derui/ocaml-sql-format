include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword

    module type Param = sig
      val literal_value : Type.parser

      val filter_clause : Type.parser
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

      let unary =
        M.bump_when T.Op_tilda <|> M.bump_when T.Op_plus
        <|> M.bump_when T.Op_minus <|> M.bump_kw Kw_not

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
        let p =
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
            wrap_parens () <|> function_ <|> literal_value () <|> bind_parameter
            <|> name <|> (unary >>= expr)
          in
          binary_operator *> expr () <|> M.skip
        in
        M.start_syntax Parser_monad.Kind.N_expr p

      and wrap_parens () =
        let* () = M.bump_when T.Tok_lparen in
        let* () = expr () in
        let* () = M.many (M.bump_when T.Tok_comma *> expr ()) *> M.skip in
        M.bump_when T.Tok_rparen
    end

    let generate v () =
      let literal_value = Parser_literal_value.generate v in
      let filter_clause = v Parser_monad.Kind.N_filter_clause in
      let module V = V (struct
        let literal_value = literal_value

        let filter_clause = filter_clause
      end) in
      V.expr ()
  end :
    Intf.GEN)
