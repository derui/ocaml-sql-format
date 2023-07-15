open Types.Ast
open Intf

module type S = PRINTER with type t = ext simple_target_specification

module Make
    (V : GEN with type t = ext host_parameter_specification)
    (Sql : GEN with type t = ext sql_parameter_reference)
    (Col : GEN with type t = ext column_reference) : S = struct
  type t = ext simple_target_specification

  let print f t ~option =
    match t with
    | Simple_target_specification (`host v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | Simple_target_specification (`sql v, _) ->
      let module Sql = (val Sql.generate ()) in
      Sql.print f ~option v
    | Simple_target_specification (`col v, _) ->
      let module Col = (val Col.generate ()) in
      Col.print f ~option v
end
