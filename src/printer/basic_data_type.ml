open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext basic_data_type

module Make (Simple : GEN with type t = ext simple_data_type) : S = struct
  type t = ext basic_data_type

  let print f t ~option =
    match t with
    | Basic_data_type (typ, as_array, _) ->
      let module Simple = (val Simple.generate ()) in
      Simple.print f typ ~option;

      if as_array then (
        Printer_token.print f Tok_lsbrace ~option;
        Printer_token.print f Tok_rsbrace ~option)
end
