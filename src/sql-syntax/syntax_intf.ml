module type S = sig
  type ('a, 'b) t

  (** [make raw] make a new [t] *)
  val make : ('a, 'b) Raw.t -> ('a, 'b) t

  (** [to_string] get string representation of [t] *)
  val to_string : ('a, 'b) t -> string
end
