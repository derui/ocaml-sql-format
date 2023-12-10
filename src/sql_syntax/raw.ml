include (
  struct
    module Token = Types.Token

    type t =
      | Node of
          { kind : Kind.node
          ; layouts : t list
          }
      | Leaf of
          { kind : Kind.leaf
          ; trailing : Trivia.trailing Trivia.t
          ; leading : Trivia.leading Trivia.t
          ; token : Token.t
          }
    [@@deriving show]

    let make_leaf ?(trailing = Trivia.trailing []) ?(leading = Trivia.leading []) token =
      Leaf { kind = Kind.token_to_leaf token; trailing; leading; token }

    let make_node kind ~layouts = Node { kind; layouts = List.rev layouts }

    let match' f = function
      | Node _ -> false
      | Leaf { token; _ } -> f token

    let replace f = function
      | Node _ as v -> v
      | Leaf (_ as v) -> Leaf { v with token = f v.token }

    let replace_trivia ?leading ?trailing = function
      | Node _ as v -> v
      | Leaf (_ as v) ->
        Leaf
          { v with
            trailing = Option.map (fun f -> f v.trailing) trailing |> Option.value ~default:v.trailing
          ; leading = Option.map (fun f -> f v.leading) leading |> Option.value ~default:v.leading
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
      | Leaf { token; leading; trailing; _ } ->
        Printf.sprintf "%s%s%s" (Trivia.to_string leading) (Token.show token) (Trivia.to_string trailing)

    let rec walk ~f t =
      match f t with
      | Some () -> (
        match t with
        | Node { layouts; _ } -> List.iter (walk ~f) layouts
        | Leaf _ -> ())
      | None -> ()
  end :
    Raw_intf.S)
