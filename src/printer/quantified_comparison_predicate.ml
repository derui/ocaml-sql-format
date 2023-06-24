open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext quantified_comparison_predicate

module Make
    (Co : GEN with type t = ext comparison_operator)
    (Subquery : GEN with type t = ext subquery)
    (Expr : GEN with type t = ext expression) : S = struct
  type t = ext quantified_comparison_predicate

  let print f t ~option =
    match t with
    | Quantified_comparison_predicate (op, kw, `expr e, _) ->
      let module Co = (val Co.generate ()) in
      let module Expr = (val Expr.generate ()) in
      Co.print f op ~option;
      Fmt.string f " ";
      let kw =
        match kw with
        | `all -> Kw_all
        | `some -> Kw_some
        | `any -> Kw_any
      in
      Printer_token.print f kw ~option;
      Fmt.string f " ";
      Printer_token.print f Tok_lparen ~option;
      Expr.print f e ~option;
      Printer_token.print f Tok_rparen ~option
    | Quantified_comparison_predicate (op, kw, `query q, _) ->
      let module Co = (val Co.generate ()) in
      let module Subquery = (val Subquery.generate ()) in
      Co.print f op ~option;
      Fmt.string f " ";
      let kw =
        match kw with
        | `all -> Kw_all
        | `some -> Kw_some
        | `any -> Kw_any
      in
      Printer_token.print f kw ~option;
      Fmt.string f " ";
      Subquery.print f q ~option
end
