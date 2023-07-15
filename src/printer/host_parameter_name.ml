open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext host_parameter_name

module Make (V : GEN with type t = ext identifier) : S = struct
  type t = ext host_parameter_name

  let print f t ~option =
    match t with
    | Host_parameter_name (v, _) ->
      Printer_token.print ~option f Tok_colon;
      let module V = (val V.generate ()) in
      V.print f ~option v
end
