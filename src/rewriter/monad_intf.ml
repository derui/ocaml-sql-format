module K = Sql_syntax.Kind
module R = Sql_syntax.Raw

module type S = sig
  type 'a t

  (** bind function *)
  val bind : 'a t -> ('a -> 'b t) -> 'b t

  (** return *)
  val return : 'a -> 'a t

  val apply : ('a -> 'b) t -> 'a t -> 'b t

  module Syntax : sig
    (** syntax for bind *)
    val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t

    (** syntax for apply *)
    val ( <*> ) : ('a -> 'b) t -> 'a t -> 'b t
  end

  module Monad_syntax : sig
    (** let-syntax for bind *)
    val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t
  end

  include module type of Syntax

  include module type of Monad_syntax

  (* Rewriter specific functions *)

  (** [leaf kind] return raw as leaf at current index. This function advances the index by one.*)
  val leaf : K.leaf -> R.t t

  (** [node kind] return raw as leaf at current index. This function advances the index by one.*)
  val node : K.node -> R.t t

  (** [new_node layouts] return new raw as same kind of node in current environment. *)
  val new_node : R.t list -> R.t t

  (** Some subrewriters. *)
  module Re : sig
    (** [keyword_case r] return raw changed case of the keyword. Case determination options are taken from the
        environment *)
    val keyword_case : R.t -> R.t t

    (** [spacer ?leading ?trailing r] return raw changed leading/trailing trivia. Default value of [leading] and
        [trailing] is [0] *)
    val spacer : ?leading:int -> ?trailing:int -> R.t -> R.t t

    (** [newline ?count r] return raw that is added newline into the leading trivia. Default value of [count] is [1] *)
    val newline : ?count:int -> R.t -> R.t t

    (** [indent_in size] make indent in rewriter. *)
    val indent_in : int -> unit t

    (** [indent_out size] make indent out in current rewriter. *)
    val indent_out : int -> unit t
  end

  (** Runner *)
  module Runner : sig
    (** [run rewriter env raw] get rewrited [raw] with [rewriter] *)
    val run : R.t t -> resolver:(K.node -> R.t t) -> options:Options.t -> R.t -> (R.t, string) result
  end
end
