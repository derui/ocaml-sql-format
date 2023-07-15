open Types.Ast
open Intf

module type S = PRINTER with type t = ext cast_target

module Make
    (V : GEN with type t = ext schema_qualified_name)
    (D : GEN with type t = ext data_type) : S = struct
  type t = ext cast_target

  let print f t ~option =
    match t with
    | Cast_target (`domain v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Cast_target (`data v, _) ->
      let module D = (val D.generate ()) in
      D.print ~option f v
end
