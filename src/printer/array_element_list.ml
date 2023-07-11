open Types.Ast
open Intf

module type S = PRINTER with type t = ext array_element_list

module Make (V : GEN with type t = ext array_element) : S = struct
  type t = ext array_element_list

  let print f t ~option =
    match t with
    | Array_element_list (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f fl;

      List.iter
        (fun e ->
          Sfmt.comma ~option f ();
          V.print ~option f e)
        list
end
