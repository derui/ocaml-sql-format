open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext searched_case

module Make
    (V : GEN with type t = ext searched_when_clause)
    (Else : GEN with type t = ext else_clause) : S = struct
  type t = ext searched_case

  let print f t ~option =
    match t with
    | Searched_case (list, els, _) ->
      Printer_token.print ~option f Kw_case;
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          List.iter
            (fun v ->
              let module V = (val V.generate ()) in
              V.print ~option f v)
            list;

          Option.iter
            (fun v ->
              let module Else = (val Else.generate ()) in
              Else.print ~option f v)
            els)
        f ();

      Printer_token.print ~option f Kw_end
end
