open Types.Ast
open Intf

module type S = PRINTER with type t = ext corresponding_column_list

module Make (V : GEN with type t = ext column_name_list) : S = struct
  type t = ext corresponding_column_list

  let print f t ~option =
    match t with
    | Corresponding_column_list (c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c
end
