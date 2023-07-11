open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext order_by_clause

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext order_by_clause

  let print f t ~option =
    match t with
    | Order_by_clause _ -> failwith "TODO: need implementation"
end
