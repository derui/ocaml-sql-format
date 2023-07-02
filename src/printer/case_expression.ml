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

      let pf f _ =
        (match list with
        | [] -> failwith "Invalid syntax"
        | (w, t) :: list ->
          Printer_token.print f Kw_when ~option;
          Fmt.string f " ";
          Expr.print f w ~option;
          Fmt.string f " ";
          Printer_token.print f Kw_then ~option;
          Fmt.string f " ";
          Expr.print f t ~option;

          List.iter
            (fun (w, t) ->
              Sfmt.newline f ();
              Printer_token.print f Kw_when ~option;
              Fmt.string f " ";
              Expr.print f w ~option;
              Fmt.string f " ";
              Printer_token.print f Kw_then ~option;
              Fmt.string f " ";
              Expr.print f t ~option)
            list);

        Option.iter
          (fun e ->
            Sfmt.newline f ();
            Printer_token.print f Kw_else ~option;
            Fmt.string f " ";
            Expr.print f e ~option)
          els
      in
      Sfmt.force_vbox option.indent_size pf f ();
      Sfmt.newline f ();
      Printer_token.print f Kw_end ~option
end
