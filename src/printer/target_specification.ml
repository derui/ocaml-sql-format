open Types.Ast
open Intf

module type S = PRINTER with type t = ext target_specification

module Make
    (V : GEN with type t = ext host_parameter_specification)
    (Sql : GEN with type t = ext sql_parameter_reference)
    (Col : GEN with type t = ext column_reference)
    (Target : GEN with type t = ext target_array_element_specification)
    (Dynamic : GEN with type t = ext dynamic_parameter_specification) : S =
struct
  type t = ext target_specification

  let print f t ~option =
    match t with
    | Target_specification (`host v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | Target_specification (`sql v, _) ->
      let module Sql = (val Sql.generate ()) in
      Sql.print f ~option v
    | Target_specification (`col v, _) ->
      let module Col = (val Col.generate ()) in
      Col.print f ~option v
    | Target_specification (`array_element v, _) ->
      let module Target = (val Target.generate ()) in
      Target.print f ~option v
    | Target_specification (`dynamic v, _) ->
      let module Dynamic = (val Dynamic.generate ()) in
      Dynamic.print f ~option v
end
