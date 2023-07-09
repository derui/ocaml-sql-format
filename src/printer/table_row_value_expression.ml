open Types.Ast
open Intf

module type S = PRINTER with type t = ext table_row_value_expression

module Make
    (V : GEN with type t = ext row_value_special_case)
    (C : GEN with type t = ext row_value_constructor) : S = struct
  type t = ext table_row_value_expression

  let print f t ~option =
    match t with
    | Table_row_value_expression (`special v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Table_row_value_expression (`row v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
end
