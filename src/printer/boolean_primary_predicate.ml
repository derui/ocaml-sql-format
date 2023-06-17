open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext boolean_primary_predicate

module Make
    (Co : GEN with type t = ext comparison_operator)
    (Cve : GEN with type t = ext common_value_expression)
    (Subquery : GEN with type t = ext subquery)
    (Expr : GEN with type t = ext expression)
    (Character : GEN with type t = ext character) : S = struct
  type t = ext boolean_primary_predicate

  let special_kw_print f ~option = function
    | `similar ->
      Printer_token.print f Kw_similar ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_to ~option
    | `like -> Printer_token.print f Kw_like ~option

  let print f t ~option =
    match t with
    | `Boolean_primary_predicate (`is_null, _) ->
      Printer_token.print f Kw_is ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_null ~option
    | `Boolean_primary_predicate (`is_not_null, _) ->
      Printer_token.print f Kw_is ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_not ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_null ~option
    | `Boolean_primary_predicate (`comparison (op, value), _) ->
      let module Co = (val Co.generate ()) in
      let module Cve = (val Cve.generate ()) in
      Co.print f op ~option;
      Fmt.string f " ";
      Cve.print f value ~option
    | `Boolean_primary_predicate (`between (s, e), _) ->
      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_between ~option;
      Fmt.string f " ";
      Cve.print f s ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_and ~option;
      Fmt.string f " ";
      Cve.print f e ~option
    | `Boolean_primary_predicate (`between_not (s, e), _) ->
      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_not ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_between ~option;
      Fmt.string f " ";
      Cve.print f s ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_and ~option;
      Fmt.string f " ";
      Cve.print f e ~option
    | `Boolean_primary_predicate (`like_regex s, _) ->
      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_like_regex ~option;
      Fmt.string f " ";
      Cve.print f s ~option
    | `Boolean_primary_predicate (`like_regex_not s, _) ->
      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_not ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_like_regex ~option;
      Fmt.string f " ";
      Cve.print f s ~option
    | `Boolean_primary_predicate (`match' (kw, e, escape), _) ->
      let module Cve = (val Cve.generate ()) in
      special_kw_print f ~option kw;
      Fmt.string f " ";
      Cve.print f e ~option;

      Option.iter
        (fun v ->
          let module Character = (val Character.generate ()) in
          Fmt.string f " ";
          Printer_token.print f Kw_escape ~option;
          Fmt.string f " ";
          Character.print f v ~option)
        escape
    | `Boolean_primary_predicate (`match_not (kw, e, escape), _) ->
      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_not ~option;
      Fmt.string f " ";
      special_kw_print f ~option kw;
      Fmt.string f " ";
      Cve.print f e ~option;

      Option.iter
        (fun v ->
          let module Character = (val Character.generate ()) in
          Fmt.string f " ";
          Printer_token.print f Kw_escape ~option;
          Fmt.string f " ";
          Character.print f v ~option)
        escape
    | `Boolean_primary_predicate (`quantified_exp (op, kw, e), _) ->
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
    | `Boolean_primary_predicate (`quantified_query (op, kw, q), _) ->
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
      Printer_token.print f Tok_lparen ~option;
      Subquery.print f q ~option;
      Printer_token.print f Tok_rparen ~option
end
