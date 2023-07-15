open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext explicit_row_value_constructor

module Make
    (V : GEN with type t = ext row_value_constructor_element)
    (EL : GEN with type t = ext row_value_constructor_element_list)
    (Subquery : GEN with type t = ext row_subquery) : S = struct
  type t = ext explicit_row_value_constructor

  let print f t ~option =
    match t with
    | Explicit_row_value_constructor (`param (fl, list), _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f fl;

          Sfmt.comma ~option f ();

          let module EL = (val EL.generate ()) in
          EL.print ~option f list)
        f ()
    | Explicit_row_value_constructor (`row v, _) ->
      Printer_token.print ~option f Kw_row;

      Sfmt.parens ~option
        (fun f _ ->
          let module EL = (val EL.generate ()) in
          EL.print ~option f v)
        f ()
    | Explicit_row_value_constructor (`subquery v, _) ->
      let module Subquery = (val Subquery.generate ()) in
      Subquery.print ~option f v
end
