open Types.Token
open Types.Ast
open Intf

module type S = PRINTER with type t = ext empty_grouping_set

module Make () : S = struct
  type t = ext empty_grouping_set

  let print f t ~option =
    match t with
    | Empty_grouping_set _ ->
      Printer_token.print ~option f Tok_lparen;
      Printer_token.print ~option f Tok_rparen
end
