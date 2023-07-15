open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext simple_value_specification

module Make
    (V : GEN with type t = ext literal)
    (Host : GEN with type t = ext host_parameter_name)
    (Sql : GEN with type t = ext sql_parameter_reference) : S = struct
  type t = ext simple_value_specification

  let print f t ~option =
    match t with
    | Simple_value_specification (`literal v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | Simple_value_specification (`host v, _) ->
      let module Host = (val Host.generate ()) in
      Host.print f ~option v
    | Simple_value_specification (`sql v, _) ->
      let module Sql = (val Sql.generate ()) in
      Sql.print f ~option v
end
