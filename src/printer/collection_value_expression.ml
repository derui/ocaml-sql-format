open Types.Ast
open Intf

module type S = PRINTER with type t = ext collection_value_expression

module Make
    (V : GEN with type t = ext array_value_expression)
    (M : GEN with type t = ext multiset_value_expression) : S = struct
  type t = ext collection_value_expression

  let print f t ~option =
    match t with
    | Collection_value_expression (`array v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Collection_value_expression (`multiset v, _) ->
      let module M = (val M.generate ()) in
      M.print ~option f v
end
