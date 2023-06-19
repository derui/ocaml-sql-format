open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext between_predicate

module Make (Cve : GEN with type t = ext common_value_expression) : S = struct
  type t = ext between_predicate

  let print f t ~option =
    match t with
    | `Between_predicate (s, e, None, _) ->
      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_between ~option;
      Fmt.string f " ";
      Cve.print f s ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_and ~option;
      Fmt.string f " ";
      Cve.print f e ~option
    | `Between_predicate (s, e, Some _, _) ->
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
end
