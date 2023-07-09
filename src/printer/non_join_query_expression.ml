open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext non_join_query_expression

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext non_join_query_expression

  let print f t ~option =
    match t with
    | Non_join_query_expression _ -> failwith "TODO: need implementation"
end
