module Token = Types.Token

module type S = sig
  type 'a t

  type leading

  type trailing

  (** [trailing tokens] make [trailing] trivia *)
  val trailing : Token.token list -> trailing t

  (** [leading tokens] make [leading] trivia *)
  val leading : Token.token list -> leading t

  (** [to_tokens trivia] get tokens from [trivia] *)
  val to_tokens : 'a t -> Token.token list

  (** [to_string trivia] get trivia *)
  val to_string : 'a t -> string
end
