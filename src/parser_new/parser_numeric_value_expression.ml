include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val term : Type.parser
    end

    module V (S : Param) = struct
      let parse () =
        let p =
          let* () = S.term () in
          let op = M.bump_when T.Op_plus <|> M.bump_when T.Op_minus in
          M.many (op *> S.term ()) *> M.skip
        in
        M.start_syntax K.N_numeric_value_expression p
    end

    let generate v () =
      let module V = V (struct
        let term = v K.N_numeric_value_expression_term
      end) in
      V.parse ()
  end :
    Intf.GEN)
