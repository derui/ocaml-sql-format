open Types.Ast
open Intf

module type S = PRINTER with type t = ext multiset_element_list

module Make (V : GEN with type t = ext multiset_element) : S = struct
  type t = ext multiset_element_list

  let print f t ~option =
    match t with
    | Multiset_element_list (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f fl;

      List.iter
        (fun v ->
          Sfmt.comma ~option f ();
          V.print ~option f v)
        list
end
