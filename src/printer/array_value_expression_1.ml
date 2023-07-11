open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_value_expression_1

module Make (V : GEN with type t = ext array_value_expression) : S = struct
  type t = ext array_value_expression_1

  let print f t ~option =
    match t with
    | Array_value_expression_1 (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
