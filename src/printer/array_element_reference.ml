open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_element_reference

module Make
    (V : GEN with type t = ext array_value_expression)
    (I : GEN with type t = ext numeric_value_expression) : S = struct
  type t = ext array_element_reference

  let print f t ~option =
    match t with
    | Array_element_reference (e, idx, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Printer_token.print ~option f Tok_lsbrace;
      let module I = (val I.generate ()) in
      I.print ~option f idx;
      Printer_token.print ~option f Tok_rsbrace
end
