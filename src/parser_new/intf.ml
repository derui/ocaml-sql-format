(** A signature to generate parser. *)
module type GEN = sig
  (** [generate map] return a parser with parser slots *)
  val generate : (module Slot_intf.S) -> Type.parser
end
