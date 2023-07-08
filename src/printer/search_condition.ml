open Types.Ast
open Intf

module type S = PRINTER with type t = ext search_condition

module Make (Expr : GEN with type t = ext boolean_value_expression) : S = struct
  type t = ext search_condition

  let print f t ~option =
    match t with
    | Search_condition (t, _) ->
      let module Expr = (val Expr.generate ()) in
      Expr.print f ~option t
end
