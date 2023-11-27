(** Environment in rewriter *)

module type S = sig
  type t = private
    { current_indent : int
    ; options : Options.t
    }

  (** [make options] makes a new environment [t]. *)
  val make : Options.t -> t

  (** [nesting_box t] gives a new environemnt from [t] what it is nested 1 level more. *)
  val nesting_box : t -> t
end
