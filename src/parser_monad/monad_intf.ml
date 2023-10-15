module type S = sig
  (** type of parser monad *)
  type 'a t

  (** [return v] add raw value to monad *)
  val return : 'a -> 'a t

  (** [map f t] apply [f] to value of [t] *)
  val map : ('a -> 'b) -> 'a t -> 'b t

  (** [apply fp xp] apply function in [fp] with [xp] *)
  val apply : ('a -> 'b) t -> 'a t -> 'b t

  (** [bind p f] bind monad *)
  val bind : 'a t -> ('a -> 'b t) -> 'b t

  (** [fail message] fail current parsing with message. *)
  val fail : string -> _ t

  (** [skip] ignore error. This function is useful with [choice] *)
  val skip : unit t

  (** [choice a b] get first success parsing. If [a] is valid, do not evaluate
      [b]. Fail if [a] and [b] are failed. *)
  val choice : 'a t -> 'a t -> 'a t

  module Let_syntax : sig
    (** A operator for bind *)
    val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t
  end

  module Syntax : sig
    (** A operator for bind *)
    val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t

    (** A operator for map *)
    val ( <$> ) : ('a -> 'b) -> 'a t -> 'b t

    (** A operator for apply *)
    val ( <*> ) : ('a -> 'b) t -> 'a t -> 'b t

    (** A operator for choice *)
    val ( <|> ) : 'a t -> 'a t -> 'a t
  end

  (** functions *)

  (** [bump_when token] bump current token into current node when the token is
      same as [token] *)
  val bump_when : Types.Token.t -> unit t

  (** [bump_kw kw] bump current token into current node when the token is same
      as [kw] *)
  val bump_kw : Types.Keyword.t -> unit t

  (** [bump_match f] bump current token into current node when the token is
      matched by [f] *)
  val bump_match : (Types.Token.t -> bool) -> unit t

  (** [bump] bump current token into current node without any conditions *)
  val bump : unit t

  (** [start_syntax kind_of_syntax inner] start syntax with [inner]. *)
  val start_syntax : Kind.node -> 'a t -> unit t
end
