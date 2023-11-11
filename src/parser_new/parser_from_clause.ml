include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val table_or_subquery : Type.parser

      val join_clause : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let* () = M.bump_kw Kw.Kw_from in
        let table_or_subquery =
          Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) (M.skip >>= D.table_or_subquery) *> M.skip
        in
        M.skip >>= D.join_clause <|> table_or_subquery
    end

    let generate taker () =
      let module P = P (struct
        let table_or_subquery = taker Sql_syntax.Kind.N_table_or_subquery

        let join_clause = taker Sql_syntax.Kind.N_join_clause
      end) in
      P.parse ()
  end :
    Intf.GEN)
