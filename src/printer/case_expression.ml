open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext case_expression

module Make (Expr : GEN with type t = ext expression) : S = struct
  type t = ext case_expression

  let print f t ~option =
    match t with
    | Case_expression (e, list, els, _) ->
      Printer_token.print f Kw_case ~option;
      Fmt.string f " ";
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Fmt.string f " ";

      List.iter
        (fun (w, t) ->
          Printer_token.print f Kw_when ~option;
          Fmt.string f " ";
          Expr.print f w ~option;
          Fmt.string f " ";
          Printer_token.print f Kw_then ~option;
          Fmt.string f " ";
          Expr.print f t ~option;
          Fmt.string f " ")
        list;

      Option.iter
        (fun e ->
          Printer_token.print f Kw_else ~option;
          Fmt.string f " ";
          Expr.print f e ~option;
          Fmt.string f " ")
        els;
      Printer_token.print f Kw_end ~option
end
