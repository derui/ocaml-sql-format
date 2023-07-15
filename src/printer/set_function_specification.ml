open Types.Ast
open Intf

module type S = PRINTER with type t = ext set_function_specification

module Make (V : GEN with type t = ext grouping_operation) : S = struct
  type t = ext set_function_specification

  let print f t ~option =
    match t with
    | Set_function_specification (`grouping v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | Set_function_specification (`aggregate _, _) ->
      failwith "need implementation"
end
