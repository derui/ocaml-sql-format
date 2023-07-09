open Types.Ast
open Intf

module type S = PRINTER with type t = ext query_expression_body

module Make
    (V : GEN with type t = ext joined_table)
    (Expr : GEN with type t = ext non_join_query_expression) : S = struct
  type t = ext query_expression_body

  let print f t ~option =
    match t with
    | Query_expression_body (`joined v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Query_expression_body (`expr v, _) ->
      let module Expr = (val Expr.generate ()) in
      Expr.print ~option f v
end
