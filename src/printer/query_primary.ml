open Parser.Ast
open Intf

module type S = PRINTER with type t = ext query_primary

module Make (P : GEN with type t = ext query) : S = struct
  type t = ext query_primary

  let print f t ~option =
    match t with
    | `Query_primary (query, _) ->
      let module P = (val P.generate ()) in
      P.print f query ~option
end
