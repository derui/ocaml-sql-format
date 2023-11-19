(** Environment in rewriter *)
type t =
  { current_indent : int
  ; options : Options.t
  }

let make (options : Options.t) = { current_indent = options.indent_size; options }
