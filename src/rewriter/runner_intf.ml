module R = Sql_syntax.Raw
module L = Sql_syntax.Language

type 'a rewriter = R.t -> 'a

module type S = sig
  (** [rewrite rewriter option language] rewrites [language] with [rewriter] and [option]. *)
  val rewrite : R.t option rewriter -> L.t -> L.t
end
