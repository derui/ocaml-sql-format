module R = Sql_syntax.Raw
module M = Monad

module Type = struct
  (** the type of selector *)
  type selector = Sql_syntax.Raw.t -> Sql_syntax.Raw.t option
end

module type S = sig
  (** [iter f] iterates all layouts in [raw]. If [raw] is not [R.Node], do not anything. *)
  val iter : (unit -> unit M.t) -> unit M.t

  (** [leaf selector ] append some leaf into monad if selected by [selector] *)
  val leaf : Type.selector -> unit M.t

  (** [leaf selector ] append some leaf into monad if selected by [selector] *)
  val node : Type.selector -> (unit -> 'a M.t) -> unit M.t

  (** [keyword selector ] append leaf as keyword into monad if selected by [selector] *)
  val keyword : Type.selector -> unit M.t

  (** [cut ?indentation] appends break hint into monad without space. *)
  val cut : ?indentation:unit -> unit -> unit M.t

  (** [sp ?sps] appends break hint with [sps]. The default value of [sps] is [1] *)
  val sp : ?sps:int -> unit -> unit M.t

  (** [spi ?sps ~indent] appends break hint with [indent] that has space [sps]. The default value of [sps] is [1] *)
  val spi : ?sps:int -> indent:int -> unit -> unit M.t

  (** [vbox] makes vbox to current environemnt. Use [Options.indent_size] to indent parameter of vbox *)
  val vbox : unit M.t

  (** [hovbox] makes hovbox to current environemnt. Use [Options.indent_size] to indent parameter of hovbox *)
  val hovbox : unit M.t
end
