module S = Sql_syntax

type raw = S.Raw.t

module type S = sig
  (** type of formatter monad *)
  type 'a t

  (** [return v] add raw value to monad *)
  val return : 'a -> 'a t

  (** [map f t] apply [f] to value of [t] *)
  val map : ('a -> 'b) -> 'a t -> 'b t

  (** [bind p f] bind monad *)
  val bind : 'a t -> ('a -> 'b t) -> 'b t

  module Let_syntax : sig
    (** A operator for bind *)
    val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t
  end

  (** functions *)

  (** [append ppf] append [ppf] to current environment *)
  val append : raw Fmt.t -> unit t

  (** Get options of current environment *)
  val options : Options.t t

  (** [replace ppf] replace current ppf to [ppf] *)
  val replace : (raw Fmt.t -> raw Fmt.t) -> unit t

  module Run : sig
    (** [run m options pf raw] run monad and print with [pf] *)
    val run : 'a t -> Options.t -> Format.formatter -> raw -> unit
  end
end
