open Types.Ast
open Intf

module type S = PRINTER with type t = ext join_column_list

module Make (N : GEN with type t = ext column_name_list) : S = struct
  type t = ext join_column_list

  let print f t ~option =
    match t with
    | Join_column_list (c, _) ->
      let module N = (val N.generate ()) in
      N.print ~option f c
end
