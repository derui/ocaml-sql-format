open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext value_specification

module Make
    (V : GEN with type t = ext literal)
    (G : GEN with type t = ext general_value_specification) : S = struct
  type t = ext value_specification

  let print f t ~option =
    match t with
    | Value_specification (`literal v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | Value_specification (`general v, _) ->
      let module G = (val G.generate ()) in
      G.print f ~option v
end
