open Types.Ast
open Intf

module type S = PRINTER with type t = ext boolean_predicand

module Make
    (V : GEN with type t = ext parenthesized_boolean_value_expression)
    (Q : GEN with type t = ext nonparenthesized_value_expression_primary) : S =
struct
  type t = ext boolean_predicand

  let print f t ~option =
    match t with
    | Boolean_predicand (`paren e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Boolean_predicand (`non e, _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f e
end
