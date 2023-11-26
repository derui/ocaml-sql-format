open Runner_intf
module K = Sql_syntax.Kind

module type S = sig
  (** [map ~rewriter ~option raw] applies [rewriter] with [options] to nodes of the [raw]. Returns list contains result
      of [rewriter] that is only [Some]. Order of results is same as original order of the [raw]. *)
  val map : rewriter:R.t option rewriter -> Env.t -> R.t -> R.t list

  (** [when_leaf leaf rewriter ~options raw] applies [rewriter] if [raw] is same kind of [leaf]. *)
  val when_leaf : K.leaf -> R.t option rewriter -> Env.t -> R.t -> R.t option

  (** [should_be_node node raw] provides assertion which [raw] is [node] or not. *)
  val should_be_node : K.node -> R.t -> unit

  (** [space ~leading ~trailing options raw] returns new [raw] that is changed leading/trailing trivia via [leading] and
      [trailing]. The default value of [leading] and [trailing] is [0]. *)
  val space : ?leading:int -> ?trailing:int -> Env.t -> R.t -> R.t option

  (** [newline ~options raw] returns new [raw] that is appended a newline. *)
  val newline : Env.t -> R.t -> R.t option

  (** [choice rewriters env raw] choices and applies a rewirter in [rewriters] to [raw] *)
  val choice : ([ `leaf of K.leaf | `node of K.node | `any ] * R.t option rewriter) list -> Env.t -> R.t -> R.t option

  (** [keyword env raw] applies special transform to [raw] with keyword options *)
  val keyword : Env.t -> R.t -> R.t option

  (** [shrink env raw] applies special transform to raw that removes all trivias without comments *)
  val shrink : Env.t -> R.t -> R.t option

  module Syntax : sig
    val ( >>= ) : 'a option -> ('a -> 'b option) -> 'b option
  end
end
