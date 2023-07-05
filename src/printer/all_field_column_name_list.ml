open Types.Ast
open Intf

module type S = PRINTER with type t = ext all_field_column_name_list

module Make (Col : GEN with type t = ext column_name_list) : S = struct
  type t = ext all_field_column_name_list

  let print f t ~option =
    match t with
    | All_field_column_name_list (col, _) ->
      let module Col = (val Col.generate ()) in
      Col.print ~option f col
end
