include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val with_clause : Type.parser

      val order_by_clause : Type.parser

      val limit_clause : Type.parser

      val select_core : Type.parser
    end

    module P (D : Data) = struct
      let compound_operator =
        let open Kw in
        let union = M.bump_kw Kw_union *> (M.bump_kw Kw_all <|> M.skip) in
        let intersect = M.bump_kw Kw_intersect in
        let except = M.bump_kw Kw_except in
        union <|> intersect <|> except

      let parse () =
        let p =
          let* () = D.with_clause () <|> M.skip in
          let* _ = Subparser.nonempty_list ~sep:compound_operator (D.select_core ()) in
          let* () = D.order_by_clause () <|> M.skip in
          let* () = D.limit_clause () <|> M.skip in
          M.return ()
        in
        M.start_syntax K.N_select_stmt p
    end

    let generate taker () =
      let module P = P (struct
        let with_clause = taker Parser_monad.Kind.N_with_clause

        let order_by_clause = taker Parser_monad.Kind.N_order_by_clause

        let limit_clause = taker Parser_monad.Kind.N_limit_clause

        let select_core = taker Parser_monad.Kind.N_select_core
      end) in
      P.parse ()
  end :
    Intf.GEN)
