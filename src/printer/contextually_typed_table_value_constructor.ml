open Types.Ast
open Types.Token
open Intf

module type S =
  PRINTER with type t = ext contextually_typed_table_value_constructor

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext contextually_typed_table_value_constructor

  let print f t ~option =
    match t with
    | Contextually_typed_table_value_expression _ ->
      failwith "TODO: need implementation"
end
