include (
  struct
    module Token = Types.Token

    type leaf_data =
      { trailing : Trivia.trailing Trivia.t
      ; leading : Trivia.leading Trivia.t
      ; token : Token.t
      }

    type t =
      | Node of
          { kind : Kind.node
          ; layouts : t list
          }
      | Leaf of
          { kind : Kind.leaf
          ; data : leaf_data
          }

    let make_leaf ?(trailing = Trivia.trailing []) ?(leading = Trivia.leading []) token =
      Leaf { kind = Kind.token_to_leaf token; data = { trailing; leading; token } }

    let make_node kind ~layouts = Node { kind; layouts = List.rev layouts }

    let match' f = function
      | Node _ -> false
      | Leaf { data = { token; _ }; _ } -> f token

    let replace f = function
      | Node _ as v -> v
      | Leaf ({ data; _ } as v) -> Leaf { v with data = { data with token = f data.token } }

    let replace_trivia ?leading ?trailing = function
      | Node _ as v -> v
      | Leaf ({ data; _ } as v) ->
        Leaf
          { v with
            data =
              { data with
                trailing = Option.map (fun f -> f data.trailing) trailing |> Option.value ~default:data.trailing
              ; leading = Option.map (fun f -> f data.leading) leading |> Option.value ~default:data.leading
              }
          }

    let push_layout raw = function
      | Node v -> Node { v with layouts = raw :: v.layouts }
      | Leaf _ as v -> v

    let replace_layouts layouts = function
      | Node v -> Node { v with layouts = List.rev layouts }
      | Leaf _ as v -> v

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
        loop @@ List.rev layouts
      | Leaf { data; _ } ->
        Printf.sprintf "%s%s%s" (Trivia.to_string data.leading) (Token.show data.token) (Trivia.to_string data.trailing)

    let rec walk ~f t =
      f t;
      match t with
      | Node { layouts; _ } -> List.iter (walk ~f) layouts
      | Leaf _ -> ()
  end :
    Raw_intf.S)
