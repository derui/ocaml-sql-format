open Types.Ast
open Intf

module type S = PRINTER with type t = ext reference_value_expression

module Make (V : GEN with type t = ext value_expression_primary) : S = struct
  type t = ext reference_value_expression

  let print f t ~option =
    match t with
    | Reference_value_expression (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
