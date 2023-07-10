open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sql_argument

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext sql_argument

  let print f t ~option =
    match t with
    | Sql_argument _ -> failwith "TODO: need implementation"
end
