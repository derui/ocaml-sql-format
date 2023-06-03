module type S = sig
  type t

  val to_string : t -> option:unit -> string
end
