open Types.Ast
open Intf

module type S = PRINTER with type t = ext when_operand

module Make (V : GEN with type t = ext row_value_predicand) : S = struct
  type t = ext when_operand

  let print f t ~option =
    match t with
    | When_operand (`row v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | When_operand (`comparison _, _) -> failwith "need implementation"
    | When_operand (`between _, _) -> failwith "need implementation"
    | When_operand (`in' _, _) -> failwith "need implementation"
    | When_operand (`character_like _, _) -> failwith "need implementation"
    | When_operand (`octet_like _, _) -> failwith "need implementation"
    | When_operand (`similar _, _) -> failwith "need implementation"
    | When_operand (`null _, _) -> failwith "need implementation"
    | When_operand (`quantified_comparison _, _) ->
      failwith "need implementation"
    | When_operand (`match' _, _) -> failwith "need implementation"
    | When_operand (`overlaps _, _) -> failwith "need implementation"
    | When_operand (`distinct _, _) -> failwith "need implementation"
    | When_operand (`member _, _) -> failwith "need implementation"
    | When_operand (`submultiset _, _) -> failwith "need implementation"
    | When_operand (`set _, _) -> failwith "need implementation"
    | When_operand (`type' _, _) -> failwith "need implementation"
end
