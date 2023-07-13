open Types.Ast
open Intf

module type S = PRINTER with type t = ext collection_type

module Make
    (V : GEN with type t = ext array_type)
    (M : GEN with type t = ext multiset_type) : S = struct
  type t = ext collection_type

  let print f t ~option =
    match t with
    | Collection_type (`array v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Collection_type (`multiset v, _) ->
      let module M = (val M.generate ()) in
      M.print ~option f v
end
