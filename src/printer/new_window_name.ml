open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext new_window_name

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext new_window_name

  let print f t ~option =
    match t with
    | New_window_name (i, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f i
end
