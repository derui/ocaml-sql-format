open Types.Ast
open Intf

module type S = PRINTER with type t = ext path_resolved_user_defined_type_name

module Make (V : GEN with type t = ext schema_qualified_name) : S = struct
  type t = ext path_resolved_user_defined_type_name

  let print f t ~option =
    match t with
    | Path_resolved_user_defined_type_name (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
