module Token = Types.Token

module type S = sig
  type 'a t

  type leading

  type trailing

  (** [trailing tokens] make [trailing] trivia *)
  val trailing : Token.t list -> trailing t

  (** [leading tokens] make [leading] trivia *)
  val leading : Token.t list -> leading t

  (** [can_trailing token] return a [token] can contains in trailing trivia *)
  val can_trailing : Token.t -> bool

  (** [can_leading token] return a [token] can contains in leading trivia *)
  val can_leading : Token.t -> bool

  (** [to_tokens trivia] get tokens from [trivia] *)
  val to_tokens : 'a t -> Token.t list

  (** [to_string trivia] get trivia *)
  val to_string : 'a t -> string
end
