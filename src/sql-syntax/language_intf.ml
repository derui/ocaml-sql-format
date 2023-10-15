module type S = sig
  (** a type of language. This type is immutable structure. *)
  type 'a t

  (** [empty] get empty instance of language *)
  val empty : unit -> 'a t

  (** [append syntax] append [syntax] to [t]. Returned instance [t] is new one. *)
  val append : 'a Syntax.t -> 'a t -> 'a t

  (** [to_string t] get string representation of [t] *)
  val to_string : 'a t -> string
end
