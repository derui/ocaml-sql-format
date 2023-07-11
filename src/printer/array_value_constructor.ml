open Types.Ast
open Intf

module type S = PRINTER with type t = ext array_value_constructor

module Make
    (V : GEN with type t = ext array_value_constructor_by_enumeration)
    (Q : GEN with type t = ext array_value_constructor_by_query) : S = struct
  type t = ext array_value_constructor

  let print f t ~option =
    match t with
    | Array_value_constructor (`enum e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Array_value_constructor (`query e, _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f e
end
