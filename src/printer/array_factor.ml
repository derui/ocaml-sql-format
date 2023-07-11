open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_factor

module Make (V : GEN with type t = ext value_expression_primary) : S = struct
  type t = ext array_factor

  let print f t ~option =
    match t with
    | Array_factor (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
