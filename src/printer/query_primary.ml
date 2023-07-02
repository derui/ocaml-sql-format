open Types.Ast
open Intf

module type S = PRINTER with type t = ext query_primary

module Make
    (P : GEN with type t = ext query)
    (EB : GEN with type t = ext query_expression_body) : S = struct
  type t = ext query_primary

  let print f t ~option =
    match t with
    | Query_primary (`query query, _) ->
      let module P = (val P.generate ()) in
      P.print f query ~option
    | Query_primary (`nested query, _) ->
      let module EB = (val EB.generate ()) in
      Sfmt.parens ~indent:() ~option (fun f _ -> EB.print f query ~option) f ()
end
