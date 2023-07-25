open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext literal_value

module Make
    (V : GEN with type t = ext string_literal)
    (N : GEN with type t = ext numeric_literal)
    (B : GEN with type t = ext blob_literal) : S = struct
  type t = ext literal_value

  let print f t ~option =
    match t with
    | Literal_value (`numeric v, _) ->
      let module N = (val N.generate ()) in
      N.print ~option f v
    | Literal_value (`string v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Literal_value (`blob v, _) ->
      let module B = (val B.generate ()) in
      B.print ~option f v
    | Literal_value (`null, _) -> Token.print ~option f Kw_null
end
