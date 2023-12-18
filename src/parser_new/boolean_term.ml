include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val boolean_factor : Type.parser
    end

    module V (S : Param) = struct
      let parse () =
        let p =
          let* () = S.boolean_factor () in
          let op = M.bump_kw Kw_and in
          M.many (op *> S.boolean_factor ()) *> M.skip
        in
        M.start_syntax K.N_boolean_term p
    end

    let generate v () =
      let module V = V (struct
        let boolean_factor = v Sql_syntax.Kind.N_boolean_factor
      end) in
      V.parse ()
  end :
    Intf.GEN)
