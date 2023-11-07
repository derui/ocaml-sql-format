include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module P = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p =
          let* () =
            M.bump_kw Kw.Kw_rollback *> (M.bump_kw Kw.Kw_transaction <|> M.skip)
          in
          let savepoint =
            M.bump_kw Kw.Kw_to *> M.bump_kw Kw.Kw_savepoint *> ident
          in
          savepoint <|> M.skip
        in
        M.start_syntax K.N_rollback_stmt p
    end

    let generate _ () = P.parse ()
  end :
    Intf.GEN)
