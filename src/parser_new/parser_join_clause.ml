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

      val join_operator : Type.parser

      val join_constraint : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let* () = D.table_or_subquery () in
          let* _ = M.many (M.skip >>= D.join_operator >>= D.table_or_subquery >>= D.join_constraint) in
          M.return ()
        in
        M.start_syntax K.N_join_clause p
    end

    let generate taker () =
      let module P = P (struct
        let table_or_subquery = taker K.N_table_or_subquery

        let join_operator = taker K.N_join_operator

        let join_constraint = taker K.N_join_constraint
      end) in
      P.parse ()
  end :
    Intf.GEN)
