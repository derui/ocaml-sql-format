open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext as_clause

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext as_clause

  let print f t ~option =
    match t with
    | As_clause (i, _) ->
      Printer_token.print ~option f Kw_as;
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print f i ~option
end
