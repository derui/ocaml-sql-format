open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_value_expression

module Make
    (V : GEN with type t = ext row_value_special_case)
    (E : GEN with type t = ext explicit_row_value_constructor) : S = struct
  type t = ext row_value_expression

  let print f t ~option =
    match t with
    | Row_value_expression (`special v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Row_value_expression (`explicit v, _) ->
      let module E = (val E.generate ()) in
      E.print ~option f v
end
