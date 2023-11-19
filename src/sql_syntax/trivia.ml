include (
  struct
    module Token = Types.Token

    type _ t =
      { tokens : Token.t list
      ; typ : [ `leading | `trailing ]
      }

    type leading

    type trailing

    let can_leading = function
      | Token.Tok_space | Tok_newline | Tok_line_comment _ | Tok_block_comment _ -> true
      | _ -> false

    let can_trailing = function
      | Token.Tok_space | Tok_block_comment _ -> true
      | _ -> false

    let leading tokens =
      assert (List.for_all can_leading tokens);
      { tokens; typ = `leading }

    let trailing tokens =
      assert (List.for_all can_trailing tokens);
      { tokens; typ = `trailing }

    let length { tokens; _ } = List.length tokens

    let to_tokens { tokens; _ } = tokens

    let to_string : 'a t -> string =
     fun { tokens; _ } ->
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

    let push token t =
      match t.typ with
      | `leading -> if can_leading token then leading (List.rev t.tokens |> List.cons token |> List.rev) else t
      | `trailing -> if can_trailing token then trailing (List.rev t.tokens |> List.cons token |> List.rev) else t

    let unshift token t =
      match t.typ with
      | `leading -> if can_leading token then leading (token :: t.tokens) else t
      | `trailing -> if can_trailing token then trailing (token :: t.tokens) else t
  end :
    Trivia_intf.S)
