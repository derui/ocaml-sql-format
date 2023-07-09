open Types.Ast
open Intf

module type S = PRINTER with type t = ext query_term

module Make
    (V : GEN with type t = ext non_join_query_term)
    (JT : GEN with type t = ext joined_table) : S = struct
  type t = ext query_term

  let print f t ~option =
    match t with
    | Query_term (`joined v, _) ->
      let module JT = (val JT.generate ()) in
      JT.print ~option f v
    | Query_term (`term v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
