open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_specification

module Make
    (Expr : GEN with type t = ext expression)
    (Order : GEN with type t = ext order_by_clause)
    (WF : GEN with type t = ext window_frame) : S = struct
  type t = ext window_specification

  let print f t ~option =
    match t with
    | Window_specification (expr, order_by, window_frame, _) ->
      Printer_token.print f Kw_over ~option;
      Fmt.string f " ";
      Printer_token.print f Tok_lparen ~option;
      (match expr with
      | [] -> ()
      | fst :: rest ->
        Printer_token.print f Kw_partition ~option;
        Fmt.string f " ";
        Printer_token.print f Kw_by ~option;
        Fmt.string f " ";
        let module Expr = (val Expr.generate ()) in
        Expr.print f fst ~option;
        List.iter
          (fun v ->
            Printer_token.print f Tok_comma ~option;
            Expr.print f v ~option)
          rest);

      Option.iter
        (fun v ->
          let module Order = (val Order.generate ()) in
          Fmt.string f " ";
          Order.print f v ~option)
        order_by;

      Option.iter
        (fun v ->
          let module WF = (val WF.generate ()) in
          Fmt.string f " ";
          WF.print f v ~option)
        window_frame;
      Printer_token.print f Tok_rparen ~option
end
