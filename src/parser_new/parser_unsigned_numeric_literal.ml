include (
  struct
    module M = Parser_monad.Monad
    module K = Sql_syntax.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    let parse () =
      let p =
        M.bump_match (function
          | T.Tok_numeric _ -> true
          | _ -> false)
      in
      M.start_syntax N_unsigned_numeric_literal p

    let generate _ = parse
  end :
    Intf.GEN)
