open Types.Ast
open Intf

module type S = PRINTER with type t = ext multiset_value_function

module Make (V : GEN with type t = ext multiset_set_function) : S = struct
  type t = ext multiset_value_function

  let print f t ~option =
    match t with
    | Multiset_value_function (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
