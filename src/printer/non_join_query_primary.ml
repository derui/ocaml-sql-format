open Types.Ast
open Intf

module type S = PRINTER with type t = ext non_join_query_primary

module Make
    (V : GEN with type t = ext simple_table)
    (Expr : GEN with type t = ext non_join_query_expression) : S = struct
  type t = ext non_join_query_primary

  let print f t ~option =
    match t with
    | Non_join_query_primary (`simple v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Non_join_query_primary (`expr v, _) ->
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          Expr.print ~option f v)
        f ()
end
