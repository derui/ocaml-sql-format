open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_value_expression

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext array_value_expression

  let print f t ~option =
    match t with
    | Array_value_expression _ -> failwith "TODO: need implementation"
end
