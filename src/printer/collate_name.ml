open Types.Ast
open Intf

module type S = PRINTER with type t = ext collate_name

module Make (Q : GEN with type t = ext schema_qualified_name) : S = struct
  type t = ext collate_name

  let print f t ~option =
    match t with
    | Collate_name (t, _) ->
      let module Q = (val Q.generate ()) in
      Q.print f ~option t
end
