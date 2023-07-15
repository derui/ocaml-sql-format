open Types.Ast
open Intf

module type S = PRINTER with type t = ext implicitly_typed_value_specification

module Make
    (V : GEN with type t = ext null_specification)
    (E : GEN with type t = ext empty_specification) : S = struct
  type t = ext implicitly_typed_value_specification

  let print f t ~option =
    match t with
    | Implicitly_typed_value_specification (`null e, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option e
    | Implicitly_typed_value_specification (`empty e, _) ->
      let module E = (val E.generate ()) in
      E.print f ~option e
end
