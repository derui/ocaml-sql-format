include (
  struct
    module Token = Types.Token

    type _ trivia = { tokens : Token.token list }

    type _leading

    type _trailing

    type leading = _leading trivia

    type trailing = _trailing trivia

    let trailing_trivia tokens =
      assert (
        List.for_all
          (function
            | Token.Tok_space
            | Tok_newline
            | Tok_line_comment _
            | Tok_block_comment _ -> true
            | _ -> false)
          tokens);
      { tokens }

    let leading_trivia tokens =
      assert (
        List.for_all
          (function
            | Token.Tok_space | Tok_block_comment _ -> true
            | _ -> false)
          tokens);
      { tokens }
  end :
    Trivia_intf.S)
