include (
  struct
    module Token = Types.Token

    type leaf_data =
      { trailing : Trivia.trailing Trivia.t
      ; leading : Trivia.leading Trivia.t
      ; token : Token.token
      }

    type 'a t =
      | Node of
          { kind : 'a
          ; layouts : 'a t list
          }
      | Leaf of
          { kind : 'a
          ; data : leaf_data
          }

    let make_leaf kind ~trailing ~leading ~token =
      Leaf { kind; data = { trailing; leading; token } }

    let make_node kind ~layouts = Node { kind; layouts }

    let rec to_string t =
      let buffer = Buffer.create 10 in
      match t with
      | Node { layouts; _ } ->
        let rec loop layouts =
          match layouts with
          | [] -> Buffer.to_bytes buffer |> Bytes.to_string
          | layout :: rest ->
            to_string layout |> Buffer.add_string buffer;
            loop rest
        in
        loop layouts
      | Leaf { data; _ } ->
        Printf.sprintf "%s%s%s"
          (Trivia.to_string data.leading)
          ""
          (Trivia.to_string data.trailing)
  end :
    Raw_intf.S)
