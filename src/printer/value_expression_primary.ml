open Types.Ast
open Intf

module type S = PRINTER with type t = ext value_expression_primary

module Make
    (V : GEN with type t = ext parenthesized_value_expression)
    (NP : GEN with type t = ext nonparenthesized_value_expression_primary) : S =
struct
  type t = ext value_expression_primary

  let print f t ~option =
    match t with
    | Value_expression_primary (`paren e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Value_expression_primary (`non_paren e, _) ->
      let module NP = (val NP.generate ()) in
      NP.print ~option f e
end
