include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val numeric_value_expression : Type.parser
    end

    module V (S : Param) = struct
      let parse () =
        let p =
          let* () = S.numeric_value_expression () in
          let op = M.bump_when T.Op_concat <|> M.bump_when T.Op_amp in
          M.many (op *> S.numeric_value_expression ()) *> M.skip
        in
        M.start_syntax K.N_common_value_expression p
    end

    let generate v () =
      let module V = V (struct
        let numeric_value_expression = v K.N_numeric_value_expression
      end) in
      V.parse ()
  end :
    Intf.GEN)
