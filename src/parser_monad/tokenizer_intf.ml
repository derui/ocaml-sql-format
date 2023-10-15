module Token = Types.Token

module type S = sig
  (** type of token *)
  type t = private
    { start_pos : Lexing.position
    ; end_pos : Lexing.position
    ; token : Token.t
    }

  (** [tokenize buf] get array of token *)
  val tokenize : Sedlexing.lexbuf -> t array
end
