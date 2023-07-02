open Types.Ast
open Intf

module type S = PRINTER with type t = ext boolean_factor

module Make (B : GEN with type t = ext boolean_primary) : S = struct
  type t = ext boolean_factor

  let print f t ~option =
    let module B = (val B.generate ()) in
    match t with
    | Boolean_factor (primary, not_op, _) ->
      let pf f _ =
        Option.iter
          (fun _ ->
            Printer_token.print f Kw_not ~option;
            Fmt.string f " ")
          not_op;
        B.print f primary ~option
      in
      Sfmt.term_box pf f ()
end
