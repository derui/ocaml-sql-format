include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type D = sig
      val join_clause : Type.parser

      val table_name : Type.parser

      val table_function : Type.parser
    end

    module P (D : D) = struct
      let rec parse () =
        let p =
          let name = D.table_name () in
          let fname = D.table_function () in
          fname <|> name
          <|> (M.skip >>= fun _ -> Wrapping.parens (parse ()) *> M.skip)
          <|> (M.skip >>= fun _ -> Wrapping.parens (D.join_clause ()))
        in
        M.start_syntax K.N_table_or_subquery p
    end

    let generate taker () =
      let module P = P (struct
        let join_clause = taker Sql_syntax.Kind.N_join_clause

        let table_name = taker Sql_syntax.Kind.N_table_or_subquery_table_name

        let table_function = taker Sql_syntax.Kind.N_table_or_subquery_table_function
      end) in
      P.parse ()
  end :
    Intf.GEN)
