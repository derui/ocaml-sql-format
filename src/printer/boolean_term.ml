open Types.Ast
open Intf

module type S = PRINTER with type t = ext boolean_term

module Make (B : GEN with type t = ext boolean_factor) : S = struct
  type t = ext boolean_term

  let print f t ~option =
    match t with
    | `Boolean_term (factor, factors, _) ->
      let module B = (val B.generate ()) in
      B.print f factor ~option;

      List.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f Kw_and ~option;
          Fmt.string f " ";
          B.print f v ~option)
        factors
end
