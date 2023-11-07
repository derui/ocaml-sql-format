include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module P = struct
      let parse () =
        let p =
          M.bump_kw Kw.Kw_commit *> (M.bump_kw Kw.Kw_transaction <|> M.skip)
        in
        M.start_syntax K.N_commit_stmt p
    end

    let generate _ () = P.parse ()
  end :
    Intf.GEN)
