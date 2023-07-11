open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_value_expression

module Make
    (V : GEN with type t = ext array_factor)
    (C : GEN with type t = ext array_concatenation) : S = struct
  type t = ext array_value_expression

  let print f t ~option =
    match t with
    | Array_value_expression (`factor factor, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f factor
    | Array_value_expression (`concat c, _) ->
      Sfmt.term_box
        (fun f _ ->
          let module C = (val C.generate ()) in
          C.print ~option f c)
        f ()
end
