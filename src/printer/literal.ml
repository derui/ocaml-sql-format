open Types.Literal
open Types.Ext
open Intf

module type S = PRINTER with type t = ext literal

module Make
    (G : GEN with type t = ext general_literal)
    (UN : GEN with type t = ext signed_numeric_literal) : S = struct
  type t = ext literal

  let print f t ~option =
    match t with
    | Literal (`numeric v, _) ->
      let module UN = (val UN.generate ()) in
      UN.print ~option f v
    | Literal (`general v, _) ->
      let module G = (val G.generate ()) in
      G.print ~option f v
end
