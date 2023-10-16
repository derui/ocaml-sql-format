module type S = sig
  (** [take t ~kind] get parser slotted in with [kind] *)
  val take : Parser_monad.Kind.node -> Type.parser
end
