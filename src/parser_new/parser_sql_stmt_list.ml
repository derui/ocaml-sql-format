include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val sql_stmt : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let stmt () = D.sql_stmt () <|> M.skip in
          let* _ = Subparser.list ~sep:(M.bump_when T.Tok_semicolon) @@ stmt () in
          M.skip
        in
        M.start_syntax K.N_sql_stmt_list p
    end

    let generate taker () =
      let module P = P (struct
        let sql_stmt = taker Sql_syntax.Kind.N_sql_stmt
      end) in
      P.parse ()
  end :
    Intf.GEN)
