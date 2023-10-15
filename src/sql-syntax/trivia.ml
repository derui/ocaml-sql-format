include (
  struct
    module Token = Types.Token

    type _ t = { tokens : Token.t list }

    type leading

    type trailing

    let leading tokens =
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

    let trailing tokens =
      assert (
        List.for_all
          (function
            | Token.Tok_space | Tok_block_comment _ -> true
            | _ -> false)
          tokens);
      { tokens }

    let to_tokens { tokens } = tokens

    let to_string : 'a t -> string =
     fun { tokens } ->
      let raws =
        List.map
          (function
            | Token.Tok_newline -> "\n"
            | Tok_space -> " "
            | Tok_line_comment v -> v
            | Tok_block_comment v -> v
            | _ -> failwith "Invalid trivia")
          tokens
      in
      String.concat "" raws
  end :
    Trivia_intf.S)
