open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext group_by_clause

module Make (Expr : GEN with type t = ext expression) : S = struct
  type t = ext group_by_clause

  let print_exps f option = function
    | [] -> ()
    | exp :: rest ->
      let module Expr = (val Expr.generate ()) in
      Expr.print f ~option exp;
      List.iter
        (fun exp ->
          Printer_token.print f ~option Tok_comma;
          Expr.print f ~option exp)
        rest

  let print f t ~option =
    match t with
    | `Group_by_clause (t, _) -> (
      Printer_token.print f ~option Kw_group;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_by;
      Fmt.string f " ";

      match t with
      | `rollup v ->
        Fmt.string f " ";
        Printer_token.print f ~option Kw_rollup;
        Fmt.string f " ";
        Printer_token.print f ~option Tok_lparen;
        print_exps f option v;
        Printer_token.print f ~option Tok_rparen
      | `default v -> print_exps f option v)
end
