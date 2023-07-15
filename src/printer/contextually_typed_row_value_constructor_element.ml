open Types.Ast
open Intf

module type S =
  PRINTER with type t = ext contextually_typed_row_value_constructor_element

module Make
    (V : GEN with type t = ext value_expression)
    (Spec : GEN with type t = ext contextually_typed_value_specification) : S =
struct
  type t = ext contextually_typed_row_value_constructor_element

  let print f t ~option =
    match t with
    | Contextually_typed_row_value_constructor_element (`expr v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Contextually_typed_row_value_constructor_element (`spec v, _) ->
      let module Spec = (val Spec.generate ()) in
      Spec.print ~option f v
end
