open Types.Ast
open Intf

module type S = PRINTER with type t = ext sort_key

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext sort_key

  let print f t ~option =
    match t with
    | Sort_key (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
