open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext field_reference

module Make
    (I : GEN with type t = ext identifier)
    (V : GEN with type t = ext value_expression_primary) : S = struct
  type t = ext field_reference

  let print f t ~option =
    match t with
    | Field_reference (v, i, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v;
      Printer_token.print ~option f Tok_period;
      let module I = (val I.generate ()) in
      I.print ~option f i
end
