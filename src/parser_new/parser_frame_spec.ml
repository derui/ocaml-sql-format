include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    open M.Let_syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    module type Data = sig
      val expr : Type.parser
    end

    module P (D : Data) = struct
      let current_row = M.bump_kw Kw.Kw_current *> M.bump_kw Kw.Kw_row

      let unbounded_preceding = M.bump_kw Kw.Kw_unbounded *> M.bump_kw Kw.Kw_preceding

      let unbounded_following = M.bump_kw Kw.Kw_unbounded *> M.bump_kw Kw.Kw_following

      let between =
        let* () = M.bump_kw Kw.Kw_between in
        let between_1 =
          current_row <|> unbounded_preceding
          <|> (M.skip >>= D.expr) *> (M.bump_kw Kw.Kw_preceding <|> M.bump_kw Kw.Kw_following)
        in
        let between_2 =
          current_row <|> unbounded_following
          <|> (M.skip >>= D.expr) *> (M.bump_kw Kw.Kw_preceding <|> M.bump_kw Kw.Kw_following)
        in
        between_1 *> M.bump_kw Kw.Kw_and *> between_2

      let frame_spec =
        let* () = M.bump_kw Kw.Kw_range <|> M.bump_kw Kw.Kw_rows <|> M.bump_kw Kw.Kw_groups in
        let* () =
          current_row <|> unbounded_preceding <|> between <|> (M.skip >>= D.expr) *> M.bump_kw Kw.Kw_preceding
        in
        let* () =
          let no_other = M.bump_kw Kw.Kw_no *> M.bump_kw Kw.Kw_others in
          let group = M.bump_kw Kw.Kw_group in
          let ties = M.bump_kw Kw.Kw_ties in
          M.bump_kw Kw.Kw_exclude *> (no_other <|> current_row <|> group <|> ties) <|> M.skip
        in
        M.return ()

      let parse () = M.start_syntax K.N_frame_spec frame_spec
    end

    let generate taker () =
      let module P = P (struct
        let expr = taker Sql_syntax.Kind.N_expr
      end) in
      P.parse ()
  end :
    Intf.GEN)
