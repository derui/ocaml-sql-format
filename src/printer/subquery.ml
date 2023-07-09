open Types.Ast
open Intf

module type S = PRINTER with type t = ext subquery

module Make (Q : GEN with type t = ext query_expression) : S = struct
  type t = ext subquery

  let print f t ~option =
    match t with
    | Subquery (qe, _) ->
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Q = (val Q.generate ()) in
          Q.print ~option f qe)
        f ()
end
