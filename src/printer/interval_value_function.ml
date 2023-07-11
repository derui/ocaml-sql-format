open Types.Ast
open Intf

module type S = PRINTER with type t = ext interval_value_function

module Make (V : GEN with type t = ext interval_absolute_value_function) : S =
struct
  type t = ext interval_value_function

  let print f t ~option =
    match t with
    | Interval_value_function (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
