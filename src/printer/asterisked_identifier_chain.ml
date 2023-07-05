open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext asterisked_identifier_chain

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext asterisked_identifier_chain

  let print f t ~option =
    match t with
    | Asterisked_identifier_chain (fi, l, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f fi;

      List.iter
        (fun i ->
          Printer_token.print ~option f Tok_period;
          I.print ~option f i)
        l
end
