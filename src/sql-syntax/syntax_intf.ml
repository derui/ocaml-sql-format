module type S = sig
  type 'a t

  (** [make raw] make a new [t] *)
  val make : 'a Raw.t -> 'a t

  (** [to_string] get string representation of [t] *)
  val to_string : 'a t -> string
end
