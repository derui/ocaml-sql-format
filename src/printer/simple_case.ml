open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext simple_case

module Make
    (V : GEN with type t = ext case_operand)
    (W : GEN with type t = ext simple_when_clause)
    (Else : GEN with type t = ext else_clause) : S = struct
  type t = ext simple_case

  let print f t ~option =
    match t with
    | Simple_case (c, clauses, els, _) ->
      Printer_token.print ~option f Kw_case;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f c;

      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          List.iter
            (fun v ->
              let module W = (val W.generate ()) in
              W.print ~option f v)
            clauses;

          Option.iter
            (fun v ->
              let module Else = (val Else.generate ()) in
              Else.print ~option f v)
            els)
        f ();

      Printer_token.print ~option f Kw_end
end
