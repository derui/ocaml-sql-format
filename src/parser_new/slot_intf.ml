type parser_taker = Sql_syntax.Kind.node -> Type.parser

module type S = sig
  (** [get_taker ()] get parser taker *)
  val get_taker : unit -> parser_taker
end
