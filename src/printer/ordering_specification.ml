open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext ordering_specification

module Make () : S = struct
  type t = ext ordering_specification

  let print f t ~option =
    match t with
    | Ordering_specification (`asc, _) -> Printer_token.print ~option f Kw_asc
    | Ordering_specification (`desc, _) -> Printer_token.print ~option f Kw_desc
end
