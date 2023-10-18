type parser_taker = Parser_monad.Kind.node -> Type.parser

module type S = sig
  (** [get_taker ()] get parser taker *)
  val get_taker : unit -> parser_taker
end
