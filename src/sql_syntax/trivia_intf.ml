module Token = Types.Token

module Type = struct
  (** type of trivia. *)
  type trivia =
    | Tr_space of int (* space only, no break *)
    | Tr_break of int (* enter spawce or indent if width is reached. *)
    | Tr_newline of int (* force newline with indent. *)
    | Tr_line_comment of string (* line comment. With force newline *)
    | Tr_block_comment of string (* a block comment. without force newline. This variant is just used as space *)

  type leading

  type trailing
end

module type S = sig
  include module type of Type

  type 'a t

  (** [trailing tokens] make [trailing] trivia *)
  val trailing : Token.t list -> trailing t

  (** [leading tokens] make [leading] trivia *)
  val leading : Token.t list -> leading t

  (** [can_trailing token] return a [token] can contains in trailing trivia *)
  val can_trailing : Token.t -> bool

  (** [can_leading token] return a [token] can contains in leading trivia *)
  val can_leading : Token.t -> bool

  (** [to_string trivia] get trivia *)
  val to_string : 'a t -> string

  (** [length trivia] get length of token in trivia *)
  val length : 'a t -> int

  (** [push token tr] pushs [token] to tail of [tr] *)
  val push : trivia -> 'a t -> 'a t

  (** [unshift token tr] pushs [token] to head of [tr] *)
  val unshift : trivia -> 'a t -> 'a t
end
