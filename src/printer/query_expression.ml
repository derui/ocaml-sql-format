open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_expression

module Make () : S = struct
  type t = ext query_expression

  let print f t ~option =
    match t with
    | Query_expression _ -> failwith "TODO: need implementation"
end
