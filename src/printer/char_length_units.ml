open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext char_length_units

module Make () : S = struct
  type t = ext char_length_units

  let print f t ~option =
    match t with
    | Char_length_units (`char, _) ->
      Printer_token.print ~option f Kw_characters
    | Char_length_units (`code, _) ->
      Printer_token.print ~option f Kw_code_units
    | Char_length_units (`octets, _) -> Printer_token.print ~option f Kw_octets
end
