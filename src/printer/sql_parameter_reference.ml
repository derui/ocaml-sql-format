open Types.Ast
open Intf

module type S = PRINTER with type t = ext sql_parameter_reference

module Make (V : GEN with type t = ext identifier_chain) : S = struct
  type t = ext sql_parameter_reference

  let print f t ~option =
    match t with
    | Sql_parameter_reference (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
