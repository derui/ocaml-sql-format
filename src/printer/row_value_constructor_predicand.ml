open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_value_constructor_predicand

module Make
    (V : GEN with type t = ext common_value_expression)
    (B : GEN with type t = ext boolean_predicand)
    (E : GEN with type t = ext explicit_row_value_constructor) : S = struct
  type t = ext row_value_constructor_predicand

  let print f t ~option =
    match t with
    | Row_value_constructor_predicand (`common v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Row_value_constructor_predicand (`boolean v, _) ->
      let module B = (val B.generate ()) in
      B.print ~option f v
    | Row_value_constructor_predicand (`explicit v, _) ->
      let module E = (val E.generate ()) in
      E.print ~option f v
end
