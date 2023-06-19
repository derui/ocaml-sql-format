open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext is_null_predicate

module Make : S = struct
  type t = ext is_null_predicate

  let print f t ~option =
    match t with
    | `Is_null_predicate (None, _) ->
      Printer_token.print f Kw_is ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_null ~option
    | `Is_null_predicate (Some _, _) ->
      Printer_token.print f Kw_is ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_not ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_null ~option
end
