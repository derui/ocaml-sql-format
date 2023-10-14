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
  end :
    Raw_intf.S)
