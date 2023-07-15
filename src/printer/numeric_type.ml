open Types.Ast
open Intf

module type S = PRINTER with type t = ext numeric_type

module Make
    (V : GEN with type t = ext exact_numeric_type)
    (T : GEN with type t = ext approximate_numeric_type) : S = struct
  type t = ext numeric_type

  let print f t ~option =
    match t with
    | Numeric_type (`exact v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Numeric_type (`approximate v, _) ->
      let module T = (val T.generate ()) in
      T.print ~option f v
end
