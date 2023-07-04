open Types.Ast
open Intf

module type S = PRINTER with type t = ext unsigned_literal

module Make
    (G : GEN with type t = ext general_literal)
    (UN : GEN with type t = ext unsigned_numeric_literal) : S = struct
  type t = ext unsigned_literal

  let print f t ~option =
    match t with
    | Unsigned_literal (`numeric v, _) ->
      let module UN = (val UN.generate ()) in
      UN.print ~option f v
    | Unsigned_literal (`general v, _) ->
      let module G = (val G.generate ()) in
      G.print ~option f v
end
