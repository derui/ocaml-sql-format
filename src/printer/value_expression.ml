open Types.Ast
open Intf

module type S = PRINTER with type t = ext value_expression

module Make
    (V : GEN with type t = ext common_value_expression)
    (B : GEN with type t = ext boolean_value_expression)
    (R : GEN with type t = ext row_value_expression) : S = struct
  type t = ext value_expression

  let print f t ~option =
    match t with
    | Value_expression (`common v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Value_expression (`boolean v, _) ->
      let module B = (val B.generate ()) in
      B.print ~option f v
    | Value_expression (`row v, _) ->
      let module R = (val R.generate ()) in
      R.print ~option f v
end
