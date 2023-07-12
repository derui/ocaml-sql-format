open Types.Ast
open Intf

module type S = PRINTER with type t = ext string_value_expression

module Make (V : GEN with type t = ext character_value_expression) : S = struct
  type t = ext string_value_expression

  let print f t ~option =
    match t with
    | String_value_expression (e, _) ->
      let module V = (val V.generate ()) in
      Sfmt.term_box (fun f _ -> V.print ~option f e) f ()
end
