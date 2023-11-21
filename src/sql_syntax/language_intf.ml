module type S = sig
  (** a type of language. This type is immutable structure. *)
  type t

  (** [empty] get empty instance of language *)
  val empty : unit -> t

  (** [append syntax] append [syntax] to [t]. Returned instance [t] is new one. *)
  val append : Raw.t -> t -> t

  (** [to_string t] get string representation of [t] *)
  val to_string : t -> string

  (** [walk ~f t] applies [f] to each raw of [t]. This function visits *all* nodes in language, and it uses depth first
      search *)
  val walk : f:(Raw.t -> unit option) -> t -> unit
end
