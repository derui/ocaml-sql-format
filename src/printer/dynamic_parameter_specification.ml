open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext dynamic_parameter_specification

module Make () : S = struct
  type t = ext dynamic_parameter_specification

  let print f t ~option =
    match t with
    | Dynamic_parameter_specification _ ->
      Printer_token.print ~option f Tok_qmark
end
