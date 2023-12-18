include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val non_numeric_literal : Type.parser

      val unsigned_numeric_literal : Type.parser

      val unsigned_value_expression_primary : Type.parser

      val numeric_value_expression : Type.parser
    end

    module V (S : Param) = struct
      let parse () =
        let p =
          let non_literal = S.non_numeric_literal () in
          let sign = M.bump_when Op_plus <|> M.bump_when Op_minus in
          let signed_literal = S.unsigned_numeric_literal () in
          let with_brace =
            let* _ = S.unsigned_value_expression_primary () in
            let index = M.bump_when Tok_lsbrace >>= S.numeric_value_expression >>= fun _ -> M.bump_when Tok_rsbrace in
            let* _ = M.many index in
            M.return ()
          in
          non_literal <|> (sign <|> M.skip >>= fun _ -> signed_literal <|> with_brace)
        in
        M.start_syntax K.N_value_expression_primary p
    end

    let generate v () =
      let module V = V (struct
        let non_numeric_literal = v K.N_non_numeric_literal

        let unsigned_numeric_literal = v K.N_unsigned_numeric_literal

        let unsigned_value_expression_primary = v K.N_unsigned_value_expression_primary

        let numeric_value_expression = v K.N_numeric_value_expression
      end) in
      V.parse ()
  end :
    Intf.GEN)
