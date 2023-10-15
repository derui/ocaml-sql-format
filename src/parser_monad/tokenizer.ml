include (
  struct
    module Token = Types.Token

    type t =
      { start_pos : Lexing.position
      ; end_pos : Lexing.position
      ; token : Token.t
      }

    let tokenize buf =
      let rec loop accum =
        match Lexer.token buf with
        | Tok_eof ->
          let start_pos, end_pos = Sedlexing.lexing_positions buf in
          List.rev ({ start_pos; end_pos; token = Tok_eof } :: accum)
        | _ as token ->
          let start_pos, end_pos = Sedlexing.lexing_positions buf in
          loop ({ start_pos; end_pos; token } :: accum)
      in
      loop [] |> Array.of_list
  end :
    Tokenizer_intf.S)
