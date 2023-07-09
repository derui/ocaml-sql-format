open Types.Ast
open Intf

module type S = PRINTER with type t = ext cycle_column_list

module Make (V : GEN with type t = ext cycle_column) : S = struct
  type t = ext cycle_column_list

  let print f t ~option =
    match t with
    | Cycle_column_list (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f fl;

      List.iter
        (fun v ->
          Sfmt.comma ~option f ();
          V.print ~option f v)
        list
end
