(** Environment in rewriter *)

include (
  struct
    type t =
      { current_indent : int
      ; options : Options.t
      }

    let make (options : Options.t) = { current_indent = options.indent_size; options }

    let nesting_box t = { t with current_indent = t.current_indent + t.options.indent_size }
  end :
    Env_intf.S)
