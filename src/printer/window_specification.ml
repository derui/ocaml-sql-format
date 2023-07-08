open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_specification

module Make (D : GEN with type t = ext window_specification_detail) : S = struct
  type t = ext window_specification

  let print f t ~option =
    match t with
    | Window_specification (v, _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module D = (val D.generate ()) in
          D.print ~option f v)
        f ()
end
