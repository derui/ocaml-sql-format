open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_expression_body

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext query_expression_body

  let print f t ~option =
    match t with
    | Query_expression_body _ -> failwith "TODO: need implementation"
end
