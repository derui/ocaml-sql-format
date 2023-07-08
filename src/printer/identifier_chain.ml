open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext identifier_chain

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext identifier_chain

  let print f t ~option =
    match t with
    | Identifier_chain (i, l, _) ->
      Printer_token.print ~option f Kw_collate;
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print f ~option i;

      List.iter
        (fun i ->
          Printer_token.print ~option f Tok_period;
          I.print f ~option i)
        l
end
