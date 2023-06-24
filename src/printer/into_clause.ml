open Types.Ast
open Intf

module type S = PRINTER with type t = ext into_clause

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext into_clause

  let print f t ~option =
    match t with
    | Into_clause (ident, _) ->
      let module I = (val I.generate ()) in
      Printer_token.print f ~option Types.Token.Kw_into;
      Fmt.string f " ";
      I.print f ident ~option
end
