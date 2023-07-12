open Types.Ast
open Intf

module type S = PRINTER with type t = ext multiset_primary

module Make
    (V : GEN with type t = ext value_expression_primary)
    (F : GEN with type t = ext multiset_value_function) : S = struct
  type t = ext multiset_primary

  let print f t ~option =
    match t with
    | Multiset_primary (`value e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Multiset_primary (`function' e, _) ->
      let module F = (val F.generate ()) in
      F.print ~option f e
end
