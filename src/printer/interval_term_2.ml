open Types.Ast
open Intf

module type S = PRINTER with type t = ext interval_term_2

module Make (V : GEN with type t = ext interval_term) : S = struct
  type t = ext interval_term_2

  let print f t ~option =
    match t with
    | Interval_term_2 (t, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f t
end
