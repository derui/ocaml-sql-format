include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module P = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let table_name =
        let schema = ident *> M.bump_when T.Tok_period in
        (schema <|> M.skip) *> ident *> (M.bump_kw Kw_as *> ident <|> M.skip)

      let parse () = M.start_syntax K.N_qualified_table_name table_name
    end

    let generate _ () = P.parse ()
  end :
    Intf.GEN)
