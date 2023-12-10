include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    let parse () =
      let p =
        let comma = M.bump_when T.Tok_comma in
        let natural = M.bump_kw Kw.Kw_natural <|> M.skip in
        let join = natural *> M.bump_kw Kw.Kw_join in
        let cross_join = M.bump_kw Kw.Kw_cross *> M.bump_kw Kw.Kw_join in
        let left_join = natural *> M.bump_kw Kw.Kw_left *> (M.bump_kw Kw.Kw_outer <|> M.skip) *> M.bump_kw Kw.Kw_join in
        let right_join =
          natural *> M.bump_kw Kw.Kw_right *> (M.bump_kw Kw.Kw_outer <|> M.skip) *> M.bump_kw Kw.Kw_join
        in
        let full_join = natural *> M.bump_kw Kw.Kw_full *> (M.bump_kw Kw.Kw_outer <|> M.skip) *> M.bump_kw Kw.Kw_join in
        let inner_join = natural *> M.bump_kw Kw.Kw_inner *> M.bump_kw Kw.Kw_join in
        comma <|> join <|> cross_join <|> left_join <|> right_join <|> full_join <|> inner_join
      in
      M.start_syntax K.N_join_operator p

    let generate _ () = parse ()
  end :
    Intf.GEN)
