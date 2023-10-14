module Token = Types.Token

module type S = sig
  type _ trivia = { tokens : Token.token list }

  type _leading

  type _trailing

  type leading = private _leading trivia

  type trailing = private _trailing trivia

  (** [trailing_trivia tokens] make [trailing] trivia *)
  val trailing_trivia : Token.token list -> trailing

  (** [leading_trivia tokens] make [leading] trivia *)
  val leading_trivia : Token.token list -> leading
end
