open Types.Ast
open Intf

module type S = PRINTER with type t = ext derived_column_list

module Make (L : GEN with type t = ext column_name_list) : S = struct
  type t = ext derived_column_list

  let print f t ~option =
    match t with
    | Derived_column_list (l, _) ->
      let module L = (val L.generate ()) in
      L.print ~option f l
end
