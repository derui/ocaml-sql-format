open Parser.Ast
open Intf

module type S = PRINTER with type t = ext boolean_factor

module Make (B : GEN with type t = ext boolean_primary) : S = struct
  type t = ext boolean_factor

  let print f t ~option =
    let module B = (val B.generate ()) in
    match t with
    | `Boolean_factor (`not' primary, _) ->
      Printer_token.print f Kw_not ~option;
      Fmt.string f " ";
      B.print f primary ~option
    | `Boolean_factor (`normal primary, _) -> B.print f primary ~option
end
