open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext row_type_body

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext row_type_body

  let print f t ~option =
    match t with
    | Row_type_body _ -> failwith "TODO: need implementation"
end
