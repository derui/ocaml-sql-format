open Types.Ast
open Intf

module type S = PRINTER with type t = ext character_primary

module Make (V : GEN with type t = ext value_expression_primary) : S = struct
  type t = ext character_primary

  let print f t ~option =
    match t with
    | Character_primary (`primary e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
