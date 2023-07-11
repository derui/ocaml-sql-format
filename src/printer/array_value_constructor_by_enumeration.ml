open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_value_constructor_by_enumeration

module Make (V : GEN with type t = ext array_element_list) : S = struct
  type t = ext array_value_constructor_by_enumeration

  let print f t ~option =
    match t with
    | Array_value_constructor_by_enumeration (e, _) ->
      Printer_token.print ~option f Kw_array;
      Printer_token.print ~option f Tok_lsbrace;
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Printer_token.print ~option f Tok_rsbrace
end
