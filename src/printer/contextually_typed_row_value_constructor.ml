open Types.Ast
open Types.Token
open Intf

module type S =
  PRINTER with type t = ext contextually_typed_row_value_constructor

module Make
    (V : GEN with type t = ext common_value_expression)
    (B : GEN with type t = ext boolean_value_expression)
    (S : GEN with type t = ext contextually_typed_value_specification)
    (E : GEN with type t = ext contextually_typed_row_value_constructor_element)
    (EL : GEN
            with type t =
              ext contextually_typed_row_value_constructor_element_list) : S =
struct
  type t = ext contextually_typed_row_value_constructor

  let print f t ~option =
    match t with
    | Contextually_typed_row_value_constructor (`common v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Contextually_typed_row_value_constructor (`boolean v, _) ->
      let module B = (val B.generate ()) in
      B.print ~option f v
    | Contextually_typed_row_value_constructor (`typed_value v, _) ->
      let module S = (val S.generate ()) in
      S.print ~option f v
    | Contextually_typed_row_value_constructor (`paren (fl, list), _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module E = (val E.generate ()) in
          E.print ~option f fl;

          Sfmt.comma ~option f ();
          let module EL = (val EL.generate ()) in
          EL.print ~option f list)
        f ()
    | Contextually_typed_row_value_constructor (`row v, _) ->
      Printer_token.print ~option f Kw_row;

      Sfmt.parens ~option
        (fun f _ ->
          let module EL = (val EL.generate ()) in
          EL.print ~option f v)
        f ()
end
