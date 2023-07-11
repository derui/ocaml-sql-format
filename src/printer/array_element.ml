open Types.Ast
open Intf

module type S = PRINTER with type t = ext array_element

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext array_element

  let print f t ~option =
    match t with
    | Array_element (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
