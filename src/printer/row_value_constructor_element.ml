open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_value_constructor_element

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext row_value_constructor_element

  let print f t ~option =
    match t with
    | Row_value_constructor_element (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
