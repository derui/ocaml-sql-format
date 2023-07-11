open Types.Ast
open Intf

module type S = PRINTER with type t = ext time_zone

module Make (V : GEN with type t = ext time_zone_specifier) : S = struct
  type t = ext time_zone

  let print f t ~option =
    match t with
    | Time_zone (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
