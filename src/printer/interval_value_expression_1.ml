open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext interval_value_expression_1

module Make (V : GEN with type t = ext interval_value_expression) : S = struct
  type t = ext interval_value_expression_1

  let print f t ~option =
    match t with
    | Interval_value_expression_1 (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
