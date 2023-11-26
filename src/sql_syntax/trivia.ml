include (
  struct
    include Trivia_intf.Type
    module Token = Types.Token

    type _ t =
      { trivias : trivia list
      ; typ : [ `leading | `trailing ]
      }

    let can_leading = function
      | Token.Tok_space | Tok_newline | Tok_line_comment _ | Tok_block_comment _ -> true
      | _ -> false

    let can_trailing = function
      | Token.Tok_space | Tok_block_comment _ -> true
      | _ -> false

    let trivia_of_tokens tokens =
      let ret : trivia list ref = ref [] in
      let rec loop accum tokens =
        match tokens with
        | [] -> if List.length accum > 0 then ret := Tr_space (List.length accum) :: !ret
        | t :: rest -> (
          match t with
          | Token.Tok_space -> loop (t :: accum) rest
          | Tok_newline ->
            ret := Tr_newline (List.length accum) :: !ret;
            loop [] rest
          | Tok_line_comment v ->
            if List.length accum > 0 then ret := Tr_space (List.length accum) :: !ret;
            ret := Tr_line_comment v :: !ret;
            loop [] rest
          | Tok_block_comment v ->
            if List.length accum > 0 then ret := Tr_space (List.length accum) :: !ret;
            ret := Tr_line_comment v :: !ret;
            loop [] rest
          | _ -> failwith "Can not convert trivia from token")
      in
      loop [] tokens;
      List.rev !ret

    let leading tokens =
      assert (List.for_all can_leading tokens);
      { trivias = trivia_of_tokens tokens; typ = `leading }

    let trailing tokens =
      assert (List.for_all can_trailing tokens);
      { trivias = trivia_of_tokens tokens; typ = `trailing }

    let length { trivias; _ } = List.length trivias

    let to_string : 'a t -> string =
     fun { trivias; _ } ->
      let raws =
        List.map
          (function
            | Tr_newline v ->
              let spaces = String.init v (Fun.const ' ') in
              Printf.sprintf "%s\n" spaces
            | Tr_break v ->
              let spaces = String.init v (Fun.const ' ') in
              Printf.sprintf "%s\n" spaces
            | Tr_space v -> String.init v (Fun.const ' ')
            | Tr_line_comment v -> Printf.sprintf "%s\n" v
            | Tr_block_comment v -> v)
          trivias
      in
      String.concat "" raws

    let push trivia t = { t with trivias = t.trivias @ [ trivia ] }

    let unshift trivia t =
      assert (
        match trivia with
        | Tr_block_comment _ | Tr_space _ -> true
        | _ -> false);
      { t with trivias = trivia :: t.trivias }

    let shrink t =
      { t with
        trivias =
          List.filter
            (function
              | Tr_line_comment _ | Tr_block_comment _ -> true
              | _ -> false)
            t.trivias
      }
  end :
    Trivia_intf.S)
