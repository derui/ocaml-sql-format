open Types.Ast
open Intf

module type S = PRINTER with type t = ext host_parameter_specification

module Make (V : GEN with type t = ext host_parameter_name) : S = struct
  type t = ext host_parameter_specification

  let print f t ~option =
    match t with
    | Host_parameter_specification (v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
end
