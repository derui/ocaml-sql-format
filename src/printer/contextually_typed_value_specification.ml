open Types.Ast
open Intf

module type S = PRINTER with type t = ext contextually_typed_value_specification

module Make
    (V : GEN with type t = ext implicitly_typed_value_specification)
    (D : GEN with type t = ext default_specification) : S = struct
  type t = ext contextually_typed_value_specification

  let print f t ~option =
    match t with
    | Contextually_typed_value_specification (`implicit e, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option e
    | Contextually_typed_value_specification (`default e, _) ->
      let module D = (val D.generate ()) in
      D.print f ~option e
end
