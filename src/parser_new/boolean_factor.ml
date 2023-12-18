include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module T = Types.Token
    module Kw = Types.Keyword
    module K = Sql_syntax.Kind

    module type Param = sig
      val boolean_primary : Type.parser
    end

    module V (S : Param) = struct
      let parse () =
        let p =
          let op = M.bump_kw Kw_not <|> M.skip in
          op *> S.boolean_primary ()
        in
        M.start_syntax K.N_boolean_factor p
    end

    let generate v () =
      let module V = V (struct
        let boolean_primary = v Sql_syntax.Kind.N_boolean_primary
      end) in
      V.parse ()
  end :
    Intf.GEN)
