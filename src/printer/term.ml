open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext term

module Make (Vep : GEN with type t = ext value_expression_primary) : S = struct
  type t = ext term

  let print f t ~option =
    match t with
    | Term (primary, primaries, _) ->
      let pf f _ =
        let module Vep = (val Vep.generate ()) in
        Vep.print f primary ~option;

        List.iter
          (fun (op, primary) ->
            Fmt.sp f ();
            (match op with
            | `star -> Printer_token.print f Op_star ~option
            | `slash -> Printer_token.print f Op_slash ~option);
            Fmt.string f " ";
            Vep.print f primary ~option)
          primaries
      in
      Sfmt.term_box pf f ()
end
