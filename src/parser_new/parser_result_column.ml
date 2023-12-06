include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module T = Types.Token
    module K = Sql_syntax.Kind
    module Kw = Types.Keyword

    module type Data = sig
      val result_column_alias : Type.parser

      val result_column_table_name : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let alias = D.result_column_alias () in
          let star = M.bump_when T.Op_star in
          let table_name = D.result_column_table_name () in
          alias <|> star <|> table_name
        in
        M.start_syntax K.N_result_column p
    end

    let generate taker () =
      let module P = P (struct
        let result_column_alias = taker Sql_syntax.Kind.N_result_column_alias

        let result_column_table_name = taker Sql_syntax.Kind.N_result_column_table_name
      end) in
      P.parse ()
  end :
    Intf.GEN)
