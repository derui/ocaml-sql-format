open Types.Ast
open Intf

module type S = PRINTER with type t = ext result_expression

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext result_expression

  let print f t ~option =
    match t with
    | Result_expression (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
