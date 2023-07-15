open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext default_specification

module Make () : S = struct
  type t = ext default_specification

  let print f t ~option =
    match t with
    | Default_specification _ -> Printer_token.print ~option f Kw_default
end
