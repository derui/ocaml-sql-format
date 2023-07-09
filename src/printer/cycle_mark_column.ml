open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext cycle_mark_column

module Make (V : GEN with type t = ext identifier) : S = struct
  type t = ext cycle_mark_column

  let print f t ~option =
    match t with
    | Cycle_mark_column (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end