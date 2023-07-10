open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext character_value_expression

module Make
    (V : GEN with type t = ext concatenation)
    (C : GEN with type t = ext character_factor) : S = struct
  type t = ext character_value_expression

  let print f t ~option =
    match t with
    | Character_value_expression (`concat c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c
    | Character_value_expression (`factor c, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f c
end
