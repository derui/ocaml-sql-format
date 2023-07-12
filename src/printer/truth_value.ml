open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext truth_value

module Make () : S = struct
  type t = ext truth_value

  let print f t ~option =
    match t with
    | Truth_value (`true', _) -> Printer_token.print ~option f Kw_true
    | Truth_value (`false', _) -> Printer_token.print ~option f Kw_false
    | Truth_value (`unknown, _) -> Printer_token.print ~option f Kw_unknown
end
