module R = Sql_syntax.Raw
module M = Monad

module Type = struct
  (** the type of selector *)
  type selector = Sql_syntax.Raw.t -> Sql_syntax.Raw.t option
end

module type S = sig
  (** [iter f] iterates all layouts in [raw]. If [raw] is not [R.Node], do not anything. *)
  val iter : (unit -> unit M.t) -> unit M.t

  (** [leaf ?leading ?trailing selector] append some leaf into monad if selected by [selector]. Optional parameters such
      as [leading] and [trailing] only works if selector returns some result. *)
  val leaf : ?leading:unit M.t -> ?trailing:unit M.t -> Type.selector -> unit M.t

  (** [leaf selector ] append some leaf into monad if selected by [selector] *)
  val node : Type.selector -> (unit -> 'a M.t) -> unit M.t

  (** [keyword ?leading ?trailing selector ] append leaf as keyword into monad if selected by [selector].

      [leading] and [trailing] optional parameters are applied if selector is matched *)
  val keyword : ?leading:unit M.t -> ?trailing:unit M.t -> Type.selector -> unit M.t

  (** [nonbreak] appends nonbreakable space into monad *)
  val nonbreak : unit M.t

  (** [cut ?indentation] appends break hint into monad without space. *)
  val cut : ?indentation:bool -> unit -> unit M.t

  (** [sp ?sps] appends break hint with [sps]. The default value of [sps] is [1] *)
  val sp : ?sps:int -> unit -> unit M.t

  (** [spi ?sps ~indent] appends break hint with [indent] that has space [sps]. The default value of [sps] is [1] *)
  val spi : ?sps:int -> indent:int -> unit -> unit M.t

  (** [vbox ?indentation m] makes vbox to current environemnt. Use [Options.indent_size] to indent parameter of vbox if
      [indentation] passed *)
  val vbox : ?indentation:bool -> 'a M.t -> unit M.t

  (** [hovbox ?indentation m] makes hovbox to current environemnt. Use [Options.indent_size] to indent parameter of
      hovbox if [indentation] passed *)
  val hovbox : ?indentation:bool -> 'a M.t -> unit M.t
end
