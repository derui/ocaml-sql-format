open Types.Ast
open Intf

module type S = PRINTER with type t = ext case_operand

module Make (V : GEN with type t = ext row_value_predicand) : S = struct
  type t = ext case_operand

  let print f t ~option =
    match t with
    | Case_operand (`row v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Case_operand (`overlap _, _) -> failwith "need implementation"
end
