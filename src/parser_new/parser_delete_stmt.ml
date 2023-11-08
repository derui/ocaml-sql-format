include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val qualified_table_name : Type.parser

      val with_clause : Type.parser

      val returning_clause : Type.parser

      val expr : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let* () = D.with_clause () <|> M.skip in
          let where = M.bump_kw Kw_where >>= D.expr <|> M.skip in
          let returning = D.returning_clause () <|> M.skip in
          M.bump_kw Kw_delete *> M.bump_kw Kw_from *> D.qualified_table_name () *> where *> returning
        in
        M.start_syntax K.N_select_stmt p
    end

    let generate taker () =
      let module P = P (struct
        let qualified_table_name = taker Parser_monad.Kind.N_qualified_table_name

        let with_clause = taker Parser_monad.Kind.N_with_clause

        let returning_clause = taker Parser_monad.Kind.N_returning_clause

        let expr = taker Parser_monad.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
