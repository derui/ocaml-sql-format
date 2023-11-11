include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val select_stmt : Type.parser

      val begin_stmt : Type.parser

      val rollback_stmt : Type.parser

      val commit_stmt : Type.parser

      val create_index_stmt : Type.parser

      val delete_stmt : Type.parser
    end

    module P (D : Data) = struct
      let parse () =
        let p =
          let explain = M.bump_kw Kw.Kw_explain *> (M.bump_kw Kw.Kw_analyze <|> M.skip) in
          let stmt () =
            D.select_stmt () <|> D.begin_stmt () <|> D.rollback_stmt () <|> D.commit_stmt () <|> D.create_index_stmt ()
            <|> D.delete_stmt ()
          in

          explain <|> M.skip >>= stmt
        in
        M.start_syntax K.N_sql_stmt p
    end

    let generate taker () =
      let module P = P (struct
        let select_stmt = taker Parser_monad.Kind.N_select_stmt

        let begin_stmt = taker Parser_monad.Kind.N_begin_stmt

        let rollback_stmt = taker Parser_monad.Kind.N_rollback_stmt

        let commit_stmt = taker Parser_monad.Kind.N_commit_stmt

        let create_index_stmt = taker Parser_monad.Kind.N_create_index_stmt

        let delete_stmt = taker Parser_monad.Kind.N_delete_stmt
      end) in
      P.parse ()
  end :
    Intf.GEN)
