open Types.Ast
open Types.Token
open Intf

module type S =
  PRINTER with type t = ext contextually_typed_row_value_expression_list

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext contextually_typed_row_value_expression_list

  let print f t ~option =
    match t with
    | Contextually_typed_row_value_expression_list _ ->
      failwith "TODO: need implementation"
end
