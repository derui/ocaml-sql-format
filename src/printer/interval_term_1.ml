open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext interval_term_1

module Make (V : GEN with type t = ext interval_term) : S = struct
  type t = ext interval_term_1

  let print f t ~option =
    match t with
    | Interval_term_1 (t, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f t
end
