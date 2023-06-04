module type S = sig
  type t

  val to_string : t -> option:Options.t -> string
end
