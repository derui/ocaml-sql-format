open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext target_array_element_specification

module Make
    (R : GEN with type t = ext target_array_reference)
    (V : GEN with type t = ext simple_value_specification) : S = struct
  type t = ext target_array_element_specification

  let print f t ~option =
    match t with
    | Target_array_element_specification (r, v, _) ->
      let module R = (val R.generate ()) in
      R.print f ~option r;
      Printer_token.print ~option f Tok_lsbrace;
      let module V = (val V.generate ()) in
      V.print f ~option v;
      Printer_token.print ~option f Tok_rsbrace
end
