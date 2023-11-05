include (
  struct
    module M = Parser_monad.Monad
    open M.Let_syntax
    open M.Syntax
    module K = Parser_monad.Kind
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
          let* () = M.bump_kw Kw.Kw_window in
          let defn = ident *> M.bump_kw Kw.Kw_as *> D.window_defn () in
          Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) defn *> M.skip
        in
        M.start_syntax K.N_window_clause p
    end

    let generate taker () =
      let module P = P (struct
        let window_defn = taker Parser_monad.Kind.N_window_defn
      end) in
      P.parse ()
  end :
    Intf.GEN)
