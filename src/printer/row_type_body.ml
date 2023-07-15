open Types.Ast
open Intf

module type S = PRINTER with type t = ext row_type_body

module Make (V : GEN with type t = ext field_definition) : S = struct
  type t = ext row_type_body

  let print f t ~option =
    match t with
    | Row_type_body (fl, list, _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f fl;

          List.iter
            (fun v ->
              Sfmt.comma ~option f ();
              V.print ~option f v)
            list)
        f ()
end
