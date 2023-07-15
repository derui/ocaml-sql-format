open Types.Ast
open Intf

module type S = PRINTER with type t = ext grouping_operation

module Make (V : GEN with type t = ext column_reference) : S = struct
  type t = ext grouping_operation

  let print f t ~option =
    match t with
    | Grouping_operation (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option fl;

      List.iter
        (fun v ->
          Sfmt.comma ~option f ();
          V.print f ~option v)
        list
end
