open Parser.Ast
open Intf

module type S = PRINTER with type t = ext condition

module Make (B : GEN with type t = ext boolean_value_expression) : S = struct
  type t = ext condition

  let print f t ~option =
    match t with
    | `Condition (exp, _) ->
      let module B = (val B.generate ()) in
      B.print f exp ~option
end
