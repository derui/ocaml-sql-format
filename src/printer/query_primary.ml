open Types.Ast
open Intf

module type S = PRINTER with type t = ext query_primary

module Make
    (V : GEN with type t = ext joined_table)
    (Non : GEN with type t = ext non_join_query_primary) : S = struct
  type t = ext query_primary

  let print f t ~option =
    match t with
    | Query_primary (`joined v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Query_primary (`non_join v, _) ->
      let module Non = (val Non.generate ()) in
      Non.print ~option f v
end
