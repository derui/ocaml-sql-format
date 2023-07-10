open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext next_value_expression

module Make (V : GEN with type t = ext schema_qualified_name) : S = struct
  type t = ext next_value_expression

  let print f t ~option =
    match t with
    | Next_value_expression (e, _) ->
      Printer_token.print ~option f Kw_next;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_value;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_for;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e
end
