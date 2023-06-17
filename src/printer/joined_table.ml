open Parser.Ast
open Intf

module type S = PRINTER with type t = ext joined_table

module Make (TP : GEN with type t = ext table_primary) : S = struct
  type t = ext joined_table

  let print f t ~option =
    match t with
    | `Joined_table (p, _) ->
      let module TP = (val TP.generate ()) in
      TP.print f p ~option
end
