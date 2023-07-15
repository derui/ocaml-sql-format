open Types.Ast
open Intf

module type S = PRINTER with type t = ext target_array_reference

module Make
    (V : GEN with type t = ext sql_parameter_reference)
    (C : GEN with type t = ext column_reference) : S = struct
  type t = ext target_array_reference

  let print f t ~option =
    match t with
    | Target_array_reference (`sql v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | Target_array_reference (`col v, _) ->
      let module C = (val C.generate ()) in
      C.print f ~option v
end
