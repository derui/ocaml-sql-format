module type S = sig
  type t

  val print : Format.formatter -> t -> option:Options.t -> unit
end
