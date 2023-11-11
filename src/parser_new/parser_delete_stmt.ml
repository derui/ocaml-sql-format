include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val qualified_table_name : Type.parser

      val with_clause : Type.parser

      val where_clause : Type.parser

      val returning_clause : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let* () = D.with_clause () <|> M.skip in
          let where = D.where_clause () <|> M.skip in
          let returning = D.returning_clause () <|> M.skip in
          M.bump_kw Kw_delete *> M.bump_kw Kw_from *> D.qualified_table_name () *> where *> returning
        in
        M.start_syntax K.N_delete_stmt p
    end

    let generate taker () =
      let module P = P (struct
        let qualified_table_name = taker Sql_syntax.Kind.N_qualified_table_name

        let with_clause = taker Sql_syntax.Kind.N_with_clause

        let returning_clause = taker Sql_syntax.Kind.N_returning_clause

        let where_clause = taker Sql_syntax.Kind.N_where_clause
      end) in
      P.parse ()
  end :
    Intf.GEN)
