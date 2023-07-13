open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_type

module Make () : S = struct
  type t = ext boolean_type

  let print f t ~option =
    match t with
    | Boolean_type _ -> Printer_token.print ~option f Kw_boolean
end
