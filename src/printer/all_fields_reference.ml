open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext all_fields_reference

module Make
    (Expr : GEN with type t = ext value_expression_primary)
    (Col : GEN with type t = ext all_field_column_name_list) : S = struct
  type t = ext all_fields_reference

  let print f t ~option =
    match t with
    | All_fields_reference (expr, col, _) ->
      let module Expr = (val Expr.generate ()) in
      Expr.print ~option f expr;
      Printer_token.print ~option f Tok_period;
      Printer_token.print ~option f Op_star;

      Option.iter
        (fun col ->
          Fmt.string f " ";
          Printer_token.print ~option f Kw_as;
          Fmt.string f " ";
          Sfmt.parens ~option
            (fun f _ ->
              let module Col = (val Col.generate ()) in
              Col.print ~option f col)
            f ())
        col
end
