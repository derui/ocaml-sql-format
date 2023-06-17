module type PRINTER = sig
  type t

  val print : Format.formatter -> t -> option:Options.t -> unit
end

(* A abstraction layer to get printer without infinite loop *)
module type GEN = sig
  type t

  val generate : unit -> (module PRINTER with type t = t)
end
