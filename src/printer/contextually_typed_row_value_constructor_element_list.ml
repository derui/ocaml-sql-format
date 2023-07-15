open Types.Ast
open Intf

module type S =
  PRINTER
    with type t = ext contextually_typed_row_value_constructor_element_list

module Make
    (V : GEN with type t = ext contextually_typed_row_value_constructor_element) :
  S = struct
  type t = ext contextually_typed_row_value_constructor_element_list

  let print f t ~option =
    match t with
    | Contextually_typed_row_value_constructor_element_list (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f fl;

      List.iter
        (fun v ->
          Sfmt.comma ~option f ();
          V.print ~option f v)
        list
end
