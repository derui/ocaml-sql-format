open Types.Ast
open Intf

module type S = PRINTER with type t = ext non_cycle_mark_value

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext non_cycle_mark_value

  let print f t ~option =
    match t with
    | Non_cycle_mark_value (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
