open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_partition_column_reference_list

module Make (C : GEN with type t = ext window_partition_column_reference) : S =
struct
  type t = ext window_partition_column_reference_list

  let print f t ~option =
    match t with
    | Window_partition_column_reference_list (fe, l, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f fe;

      List.iter
        (fun v ->
          Sfmt.comma ~option f ();
          C.print ~option f v)
        l
end
