include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val value_expression_primary : Type.parser
    end

    module V (S : Param) = struct
      let parse () =
        let p =
          let* _ = S.value_expression_primary () in
          let op = M.bump_when Op_star <|> M.bump_when Op_slash in
          M.many (op >>= S.value_expression_primary)
        in
        M.start_syntax K.N_numeric_value_expression_term p
    end

    let generate v () =
      let module V = V (struct
        let value_expression_primary = v K.N_value_expression_primary
      end) in
      V.parse ()
  end :
    Intf.GEN)
