module T = Trivia
module Token = Types.Token

module type Leaf_data = sig end

module type S = sig
  type leaf_data

  type 'a t =
    | Node of
        { kind : 'a
        ; layouts : 'a t list
        }
    | Leaf of
        { kind : 'a
        ; data : leaf_data
        }

  (** [make_leaf kind ~leading ~trailing ~token] make a new leaf data *)
  val make_leaf :
       'a
    -> trailing:Trivia.trailing Trivia.t
    -> leading:Trivia.leading Trivia.t
    -> token:Token.t
    -> 'a t

  (** [make_node kind ~layouts] make a new node *)
  val make_node : 'a -> layouts:'a t list -> 'a t

  (** [to_string t] get string representation of [t] *)
  val to_string : 'a t -> string
end
