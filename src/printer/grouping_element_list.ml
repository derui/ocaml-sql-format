open Types.Ast
open Intf

module type S = PRINTER with type t = ext grouping_element_list

module Make (I : GEN with type t = ext grouping_element) : S = struct
  type t = ext grouping_element_list

  let print f t ~option =
    match t with
    | Grouping_element_list (fc, cl, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f fc;

      List.iter
        (fun c ->
          Sfmt.comma ~option f ();
          I.print ~option f c)
        cl
end
