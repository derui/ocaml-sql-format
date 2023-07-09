open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext row_value_special_case

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext row_value_special_case

  let print f t ~option =
    match t with
    | Row_value_special_case _ -> failwith "TODO: need implementation"
end
