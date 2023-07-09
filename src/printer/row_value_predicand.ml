open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext row_value_predicand

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext row_value_predicand

  let print f t ~option =
    match t with
    | Row_value_predicand _ -> failwith "TODO: need implementation"
end
