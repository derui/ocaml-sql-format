open Types.Ast
open Intf

module type S = PRINTER with type t = ext time_precision

module Make (V : GEN with type t = ext time_fractional_seconds_precision) : S =
struct
  type t = ext time_precision

  let print f t ~option =
    match t with
    | Time_precision (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
