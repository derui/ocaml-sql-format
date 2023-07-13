open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext precision

module Make (V : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext precision

  let print f t ~option =
    match t with
    | Precision (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
end
