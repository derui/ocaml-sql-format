open Types.Ast
open Intf

module type S = PRINTER with type t = ext ordinary_grouping_set

module Make
    (R : GEN with type t = ext grouping_column_reference)
    (L : GEN with type t = ext grouping_column_reference_list) : S = struct
  type t = ext ordinary_grouping_set

  let print f t ~option =
    match t with
    | Ordinary_grouping_set (`column c, _) ->
      let module R = (val R.generate ()) in
      R.print f ~option c
    | Ordinary_grouping_set (`list l, _) ->
      let ppf f _ =
        let module L = (val L.generate ()) in
        L.print f ~option l
      in
      Sfmt.parens ~option ppf f ()
end
