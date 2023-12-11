include (
  struct
    module M = Parser_monad.Monad
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module P = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p = Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) ident in
        M.start_syntax K.N_column_name_list p
    end

    let generate _ () = P.parse ()
  end :
    Intf.GEN)
