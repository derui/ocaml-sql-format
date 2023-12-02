(** Options for formatter *)
type t =
  { indent_size : int
  ; keyword_case : [ `upper | `lower | `as_is ]
  ; align_alias : bool
  ; alias_normalize : bool
  }

let default = { indent_size = 4; keyword_case = `lower; align_alias = true; alias_normalize = true }
