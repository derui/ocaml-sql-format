open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_subquery

module Make
    (I : GEN with type t = ext identifier)
    (QExpr : GEN with type t = ext query_expression) : S = struct
  type t = ext table_subquery

  let print f t ~option =
    match t with
    | `Table_subquery (prefix, expr, ident, _) ->
      let module QExpr = (val QExpr.generate ()) in
      let module I = (val I.generate ()) in
      Option.iter
        (fun v ->
          let kw =
            match v with
            | `table -> Kw_table
            | `lateral -> Kw_lateral
          in
          Printer_token.print f kw ~option;
          Fmt.string f " ")
        prefix;
      Printer_token.print f Tok_lparen ~option;
      QExpr.print f expr ~option;
      Printer_token.print f Tok_rparen ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_as ~option;
      Fmt.string f " ";
      I.print f ident ~option
end
