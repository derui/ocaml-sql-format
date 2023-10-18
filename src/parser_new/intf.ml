(** A signature to generate parser. *)
module type GEN = sig
  (** [generate map] return a parser with parser slots *)
  val generate : Slot_intf.parser_taker -> Type.parser
end
