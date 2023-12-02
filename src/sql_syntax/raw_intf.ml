module T = Trivia
module Token = Types.Token

module type Leaf_data = sig end

module type S = sig
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

  (** [make_leaf ~leading ~trailing token] make a new leaf data. If trivias not given, use empty trivia as default *)
  val make_leaf : ?trailing:Trivia.trailing Trivia.t -> ?leading:Trivia.leading Trivia.t -> Token.t -> t

  (** [make_node kind ~layouts] make a new node *)
  val make_node : Kind.node -> layouts:t list -> t

  (** [match' f t] return the [t] is matched with [f]. If [t] is Node, always return false. *)
  val match' : (Token.t -> bool) -> t -> bool

  (** [replace f t] return the new [t] that is replaced data from [f]. If [t] is Node, this returns same instance of
      [t]. *)
  val replace : (Token.t -> Token.t) -> t -> t

  (** [replace_trivia ~leading ~trailing t] replace trivia of [t]. If neithor leading nor trailing is given, this
      function does nothing. *)
  val replace_trivia :
       ?leading:(Trivia.leading Trivia.t -> Trivia.leading Trivia.t)
    -> ?trailing:(Trivia.trailing Trivia.t -> Trivia.trailing Trivia.t)
    -> t
    -> t

  (** [push_layout raw t] push [raw] into layout of [t]. Returns new instance of [t]. If [t] is leaf, this function do
      not anything *)
  val push_layout : t -> t -> t

  (** [replace_layouts layouts raw] return new [t] with given [layouts]. If [t] is leaf, this function do not anything *)
  val replace_layouts : t list -> t -> t

  (** [to_string t] get string representation of [t] *)
  val to_string : t -> string

  (** [walk ~f t] applies [f] to each raw of [t]. This function visits *all* nodes in raw, and it uses depth first
      search *)
  val walk : f:(t -> unit option) -> t -> unit
end
