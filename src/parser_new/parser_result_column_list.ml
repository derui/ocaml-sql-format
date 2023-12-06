include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module T = Types.Token
    module K = Sql_syntax.Kind
    module Kw = Types.Keyword

    module type Data = sig
      val result_column : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p = Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) (M.skip >>= D.result_column) in
        M.start_syntax K.N_result_column_list p
    end

    let generate taker () =
      let module P = P (struct
        let result_column = taker Sql_syntax.Kind.N_result_column
      end) in
      P.parse ()
  end :
    Intf.GEN)
