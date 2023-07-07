open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext schema_name

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext schema_name

  let print f t ~option =
    match t with
    | Schema_name (c, i, _) ->
      let module I = (val I.generate ()) in
      Option.iter
        (fun c ->
          I.print ~option f c;
          Printer_token.print ~option f Tok_period)
        c;
      I.print ~option f i
end
