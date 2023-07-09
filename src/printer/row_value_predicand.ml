open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_value_predicand

module Make
    (V : GEN with type t = ext row_value_special_case)
    (C : GEN with type t = ext row_value_constructor_predicand) : S = struct
  type t = ext row_value_predicand

  let print f t ~option =
    match t with
    | Row_value_predicand (`special v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Row_value_predicand (`row v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
end
