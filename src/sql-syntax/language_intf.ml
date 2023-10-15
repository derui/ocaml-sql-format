module type S = sig
  (** a type of language. This type is immutable structure. *)
  type ('a, 'b) t

  (** [empty] get empty instance of language *)
  val empty : unit -> ('a, 'b) t

  (** [append syntax] append [syntax] to [t]. Returned instance [t] is new one. *)
  val append : ('a, 'b) Raw.t -> ('a, 'b) t -> ('a, 'b) t

  (** [to_string t] get string representation of [t] *)
  val to_string : ('a, 'b) t -> string
end
