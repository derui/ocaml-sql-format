open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext null_specification

module Make () : S = struct
  type t = ext null_specification

  let print f t ~option =
    match t with
    | Null_specification _ -> Printer_token.print ~option f Kw_null
end
