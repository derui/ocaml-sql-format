open Types.Ast
open Intf

module type S = PRINTER with type t = ext numeric_primary

module Make (V : GEN with type t = ext value_expression_primary) : S = struct
  type t = ext numeric_primary

  let print f t ~option =
    match t with
    | Numeric_primary (`primary e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Numeric_primary (`function' _, _) -> failwith "need implementation"
end
