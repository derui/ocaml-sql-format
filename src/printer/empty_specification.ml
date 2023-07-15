open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext empty_specification

module Make () : S = struct
  type t = ext empty_specification

  let print f t ~option =
    match t with
    | Empty_specification (`array, _) ->
      Printer_token.print ~option f Kw_array;
      Printer_token.print ~option f Tok_lsbrace;
      Printer_token.print ~option f Tok_rsbrace
    | Empty_specification (`multiset, _) ->
      Printer_token.print ~option f Kw_multiset;
      Printer_token.print ~option f Tok_lsbrace;
      Printer_token.print ~option f Tok_rsbrace
end
