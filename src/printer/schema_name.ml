open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext schema_name

module Make (V : GEN with type t = ext identifier) : S = struct
  type t = ext schema_name

  let print f t ~option =
    match t with
    | Schema_name (v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
