open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext current_date_value_function

module Make () : S = struct
  type t = ext current_date_value_function

  let print f t ~option =
    match t with
    | Current_date_value_function _ ->
      Printer_token.print ~option f Kw_current_date
end
