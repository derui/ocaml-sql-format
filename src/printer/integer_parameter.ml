open Types.Ast
open Intf

module type S = PRINTER with type t = ext integer_parameter

module Make (Exp : GEN with type t = ext unsigned_value_expression_primary) :
  S = struct
  type t = ext integer_parameter

  let print f t ~option =
    match t with
    | Integer_parameter (`unsigned_integer (Unsigned_integer (v, _)), _) ->
      Fmt.string f v
    | Integer_parameter (`expression v, _) ->
      let module Exp = (val Exp.generate ()) in
      Exp.print f v ~option
end
