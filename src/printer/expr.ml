open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext expr

module Make
    (V : GEN with type t = ext literal_value)
    (Parameter : GEN with type t = ext bind_parameter)
    (Name : GEN with type t = ext qualified_name) : S = struct
  type t = ext expr

  let print f t ~option =
    match t with
    | Expr (`literal v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Expr (`parameter v, _) ->
      let module Parameter = (val Parameter.generate ()) in
      Parameter.print ~option f v
    | Expr (`name v, _) ->
      let module Name = (val Name.generate ()) in
      Name.print ~option f v
end
