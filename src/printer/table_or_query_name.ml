open Types.Ast
open Intf

module type S = PRINTER with type t = ext table_or_query_name

module Make
    (T : GEN with type t = ext table_name)
    (Q : GEN with type t = ext query_name) : S = struct
  type t = ext table_or_query_name

  let print f t ~option =
    match t with
    | Table_or_query_name (`query q, _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f q
    | Table_or_query_name (`table q, _) ->
      let module T = (val T.generate ()) in
      T.print ~option f q
end
