include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module T = Types.Token
    module K = Sql_syntax.Kind
    module Kw = Types.Keyword

    module P = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p = ident *> M.bump_when T.Tok_period *> M.bump_when T.Op_star in
        M.start_syntax K.N_result_column_table_name p
    end

    let generate _ () = P.parse ()
  end :
    Intf.GEN)
