open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext simple_when_clause

module Make
    (V : GEN with type t = ext when_operand)
    (R : GEN with type t = ext result') : S = struct
  type t = ext simple_when_clause

  let print f t ~option =
    match t with
    | Simple_when_clause (v, r, _) ->
      Printer_token.print ~option f Kw_when;
      let module V = (val V.generate ()) in
      V.print ~option f v;
      Printer_token.print ~option f Kw_then;
      let module R = (val R.generate ()) in
      R.print ~option f r
end
