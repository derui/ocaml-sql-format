open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext data_type

module Make
    (Basic : GEN with type t = ext basic_data_type)
    (I : GEN with type t = ext identifier) : S = struct
  type t = ext data_type

  let print f t ~option =
    match t with
    | Data_type (`basic basic, _) ->
      let module Basic = (val Basic.generate ()) in
      Basic.print f basic ~option
    | Data_type (`other (ident, as_array), _) ->
      let module I = (val I.generate ()) in
      I.print f ident ~option;

      if as_array then (
        Printer_token.print f Tok_lsbrace ~option;
        Printer_token.print f Tok_rsbrace ~option)
end
