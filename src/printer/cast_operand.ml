open Types.Ast
open Intf

module type S = PRINTER with type t = ext cast_operand

module Make
    (V : GEN with type t = ext value_expression)
    (D : GEN with type t = ext implicitly_typed_value_specification) : S =
struct
  type t = ext cast_operand

  let print f t ~option =
    match t with
    | Cast_operand (`expr v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Cast_operand (`implicit v, _) ->
      let module D = (val D.generate ()) in
      D.print ~option f v
end
