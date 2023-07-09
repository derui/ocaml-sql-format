open Types.Ast
open Intf

module type S = PRINTER with type t = ext with_list

module Make (V : GEN with type t = ext with_list_element) : S = struct
  type t = ext with_list

  let print f t ~option =
    match t with
    | With_list (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f fl;

      List.iter
        (fun v ->
          Fmt.cut f ();
          Sfmt.comma ~option f ();
          V.print ~option f v)
        list
end
