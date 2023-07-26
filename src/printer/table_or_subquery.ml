open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_or_subquery

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext table_or_subquery

  let print f t ~option =
    match t with
    | Table_or_subquery _ -> failwith "TODO: need implementation"
end
