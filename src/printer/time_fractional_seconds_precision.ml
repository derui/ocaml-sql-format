open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext time_fractional_seconds_precision

module Make (V : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext time_fractional_seconds_precision

  let print f t ~option =
    match t with
    | Time_fractional_seconds_precision (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
