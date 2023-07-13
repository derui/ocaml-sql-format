open Types.Ast
open Intf

module type S = PRINTER with type t = ext referenced_type

module Make (V : GEN with type t = ext path_resolved_user_defined_type_name) :
  S = struct
  type t = ext referenced_type

  let print f t ~option =
    match t with
    | Referenced_type (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
