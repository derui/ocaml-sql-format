open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_value_special_case

module Make
    (V : GEN with type t = ext nonparenthesized_value_expression_primary) : S =
struct
  type t = ext row_value_special_case

  let print f t ~option =
    match t with
    | Row_value_special_case (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
