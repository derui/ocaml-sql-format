module Token = Types.Token

module type S = sig
  type 'a trivia

  type leading

  type trailing

  (** [trailing tokens] make [trailing] trivia *)
  val trailing : Token.token list -> trailing trivia

  (** [leading tokens] make [leading] trivia *)
  val leading : Token.token list -> leading trivia

  (** [to_tokens trivia] get tokens from [trivia] *)
  val to_tokens : 'a trivia -> Token.token list

  (** [to_string trivia] get trivia *)
  val to_string : 'a trivia -> string
end
