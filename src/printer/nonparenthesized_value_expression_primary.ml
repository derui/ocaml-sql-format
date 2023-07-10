open Types.Ast
open Intf

module type S =
  PRINTER with type t = ext nonparenthesized_value_expression_primary

module Make (V : GEN with type t = ext column_reference) : S = struct
  type t = ext nonparenthesized_value_expression_primary

  let print f t ~option =
    match t with
    | Nonparenthesized_value_expression_primary (`column c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c
end
