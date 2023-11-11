module T = Trivia
module Token = Types.Token

module type Leaf_data = sig end

module type S = sig
  type leaf_data

  type t =
    | Node of
        { kind : Kind.node
        ; layouts : t list
        }
    | Leaf of
        { kind : Kind.leaf
        ; data : leaf_data
        }

  (** [make_leaf kind ~leading ~trailing ~token] make a new leaf data *)
  val make_leaf :
    Kind.leaf -> trailing:Trivia.trailing Trivia.t -> leading:Trivia.leading Trivia.t -> token:Token.t -> t

  (** [make_node kind ~layouts] make a new node *)
  val make_node : Kind.node -> layouts:t list -> t

  (** [match' f t] return the [t] is matched with [f]. If [t] is Node, always return false. *)
  val match' : (Token.t -> bool) -> t -> bool

  (** [push_layout raw t] push [raw] into layout of [t]. Returns new instance of [t]. If [t] is leaf, this function do
      not anything *)
  val push_layout : t -> t -> t

  (** [to_string t] get string representation of [t] *)
  val to_string : t -> string
end
