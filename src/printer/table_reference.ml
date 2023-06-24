open Types.Ast
open Intf

module type S = PRINTER with type t = ext table_reference

module Make (JT : GEN with type t = ext joined_table) : S = struct
  type t = ext table_reference

  let print f t ~option =
    match t with
    | `Table_reference (jt, _) ->
      let module JT = (val JT.generate ()) in
      JT.print f jt ~option
end
