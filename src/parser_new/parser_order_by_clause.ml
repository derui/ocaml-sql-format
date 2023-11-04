include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val ordering_term : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let* () = M.bump_kw Kw.Kw_order *> M.bump_kw Kw.Kw_by in
          let* _ =
            Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma)
              (M.skip >>= D.ordering_term)
          in
          M.return ()
        in
        M.start_syntax K.N_order_by_clause p
    end

    let generate taker () =
      let module P = P (struct
        let ordering_term = taker Parser_monad.Kind.N_ordering_term
      end) in
      P.parse ()
  end :
    Intf.GEN)
