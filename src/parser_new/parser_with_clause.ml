include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val common_table_expression : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let* () = M.bump_kw Kw.Kw_with *> (M.bump_kw Kw.Kw_recursive <|> M.skip) in
          let* _ = Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma) (D.common_table_expression ()) in
          M.skip
        in
        M.start_syntax K.N_with_clause p
    end

    let generate taker () =
      let module P = P (struct
        let common_table_expression = taker Parser_monad.Kind.N_common_table_expression
      end) in
      P.parse ()
  end :
    Intf.GEN)
