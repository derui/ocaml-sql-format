open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sql_argument_list

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext sql_argument_list

  let print f t ~option =
    match t with
    | Sql_argument_list _ -> failwith "TODO: need implementation"
end
