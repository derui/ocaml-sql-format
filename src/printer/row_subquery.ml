open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_subquery

module Make (Q : GEN with type t = ext subquery) : S = struct
  type t = ext row_subquery

  let print f t ~option =
    match t with
    | Row_subquery (q, _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f q
end
