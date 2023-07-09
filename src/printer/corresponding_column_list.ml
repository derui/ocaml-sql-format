open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext corresponding_column_list

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext corresponding_column_list

  let print f t ~option =
    match t with
    | Corresponding_column_list _ -> failwith "TODO: need implementation"
end
