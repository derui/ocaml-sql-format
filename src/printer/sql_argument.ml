open Types.Ast
open Intf

module type S = PRINTER with type t = ext sql_argument

module Make
    (V : GEN with type t = ext value_expression)
    (G : GEN with type t = ext generalized_expression) : S = struct
  type t = ext sql_argument

  let print f t ~option =
    match t with
    | Sql_argument (`value e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Sql_argument (`generalized e, _) ->
      let module G = (val G.generate ()) in
      G.print ~option f e
end
