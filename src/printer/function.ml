open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext function'

module Make
    (Expr : GEN with type t = ext expression)
    (Data_type : GEN with type t = ext data_type) : S = struct
  type t = ext function'

  let print_substring f t ~option =
    match t with
    | `substring (e, `from_for (from', for_)) ->
      Printer_token.print f Kw_substring ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_from ~option;
      Fmt.string f " ";
      Expr.print f from' ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f Kw_for ~option;
          Fmt.string f " ";
          Expr.print f v ~option)
        for_;
      Printer_token.print f Tok_rparen ~option
    | `substring (e, `list l) ->
      Printer_token.print f Kw_substring ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      List.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Fmt.string f " ";
          Expr.print f v ~option)
        l;
      Printer_token.print f Tok_rparen ~option

  let print f t ~option =
    match t with
    | Function (`convert (e, d), _) ->
      Printer_token.print f Kw_convert ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Printer_token.print f Tok_comma ~option;
      Fmt.string f " ";
      let module Data_type = (val Data_type.generate ()) in
      Data_type.print f d ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`cast (e, d), _) ->
      Printer_token.print f Kw_cast ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_as ~option;
      Fmt.string f " ";
      let module Data_type = (val Data_type.generate ()) in
      Data_type.print f d ~option;
      Printer_token.print f Tok_rparen ~option
    | Function ((`substring _ as t), _) -> print_substring f t ~option
end
