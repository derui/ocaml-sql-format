open Types.Ast
open Intf

module type S = PRINTER with type t = ext boolean_primary

module Make (V : GEN with type t = ext boolean_predicand) : S = struct
  type t = ext boolean_primary

  let print f t ~option =
    match t with
    | Boolean_primary (`predicand e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
