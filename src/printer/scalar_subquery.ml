open Types.Ast
open Intf

module type S = PRINTER with type t = ext scalar_subquery

module Make (Q : GEN with type t = ext subquery) : S = struct
  type t = ext scalar_subquery

  let print f t ~option =
    match t with
    | Scalar_subquery (q, _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f q
end
