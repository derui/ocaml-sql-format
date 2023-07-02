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
          Fmt.cut f ();
          Expr.print f ~option exp)
        rest

  let print f t ~option =
    match t with
    | Group_by_clause (t, _) ->
      Printer_token.print f ~option Kw_group;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_by;

      let pf f _ =
        match t with
        | `rollup v ->
          Fmt.string f " ";
          Printer_token.print f ~option Kw_rollup;
          Fmt.string f " ";
          Sfmt.parens ~indent:() ~option (fun f _ -> print_exps f option v) f ()
        | `default v -> print_exps f option v
      in
      Sfmt.force_vbox option.indent_size pf f ()
end
