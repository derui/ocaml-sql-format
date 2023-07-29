open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_statement

module Make (V : GEN with type t = ext select_core) : S = struct
  type t = ext select_statement

  let print f t ~option =
    match t with
    | Select_statement (c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c
end
