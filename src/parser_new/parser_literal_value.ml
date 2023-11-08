include (
  struct
    module M = Parser_monad.Monad
    open M.Syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    let parse () =
      M.bump_match (function
        | T.Tok_string _ -> true
        | _ -> false)
      <|> M.bump_match (function
            | T.Tok_numeric _ -> true
            | _ -> false)
      <|> M.bump_match (function
            | T.Tok_blob _ -> true
            | _ -> false)
      <|> M.bump_kw Kw.Kw_null <|> M.bump_kw Kw.Kw_true <|> M.bump_kw Kw.Kw_false <|> M.bump_kw Kw.Kw_current_time
      <|> M.bump_kw Kw.Kw_current_date <|> M.bump_kw Kw.Kw_current_timestamp

    let generate _ = parse
  end :
    Intf.GEN)
