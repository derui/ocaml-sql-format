include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val window_defn : Type.parser
    end

    module P (D : Data) = struct
      let ident =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      let parse () =
        let p =
          let* () = M.bump_kw Kw.Kw_over in
          let name = ident in
          let defn = D.window_defn () in
          name <|> defn
        in
        M.start_syntax K.N_over_clause p
    end

    let generate taker () =
      let module P = P (struct
        let window_defn = taker Sql_syntax.Kind.N_window_defn
      end) in
      P.parse ()
  end :
    Intf.GEN)
