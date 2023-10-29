include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val table_or_subquery : Type.parser

      val expr : Type.parser
    end

    module P (D : Data) = struct
      let rec parse () =
        let p =
          let* () = D.table_or_subquery () in
          let* _ =
            M.many
              (M.skip >>= join_operator >>= D.table_or_subquery
             >>= join_constraint)
          in
          M.return ()
        in
        M.start_syntax K.N_join_clause p

      and join_operator () =
        let comma = M.bump_when T.Tok_comma in
        let natural = M.bump_kw Kw.Kw_natural <|> M.skip in
        let join = natural *> M.bump_kw Kw.Kw_join in
        let cross_join = M.bump_kw Kw.Kw_cross *> M.bump_kw Kw.Kw_join in
        let left_join =
          natural *> M.bump_kw Kw.Kw_left
          *> (M.bump_kw Kw.Kw_outer <|> M.skip)
          *> M.bump_kw Kw.Kw_join
        in
        let right_join =
          natural *> M.bump_kw Kw.Kw_right
          *> (M.bump_kw Kw.Kw_outer <|> M.skip)
          *> M.bump_kw Kw.Kw_join
        in
        let full_join =
          natural *> M.bump_kw Kw.Kw_full
          *> (M.bump_kw Kw.Kw_outer <|> M.skip)
          *> M.bump_kw Kw.Kw_join
        in
        let inner_join =
          natural *> M.bump_kw Kw.Kw_inner *> M.bump_kw Kw.Kw_join
        in
        comma <|> join <|> cross_join <|> left_join <|> right_join <|> full_join
        <|> inner_join

      and ident () =
        M.bump_match (function
          | T.Tok_ident _ -> true
          | _ -> false)

      and join_constraint () =
        let on_ = M.bump_kw Kw.Kw_on >>= D.expr in
        let using =
          M.bump_kw Kw.Kw_using
          *> Wrapping.parens
               (Subparser.nonempty_list ~sep:(M.bump_when T.Tok_comma)
                  (ident ()))
        in
        on_ <|> using <|> M.skip
    end

    let generate taker () =
      let expr = taker Parser_monad.Kind.N_expr in
      let table_or_subquery = taker Parser_monad.Kind.N_table_or_subquery in
      let module P = P (struct
        let expr = expr

        let table_or_subquery = table_or_subquery
      end) in
      P.parse ()
  end :
    Intf.GEN)
