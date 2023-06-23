open Parser.Ast
open Intf

module type S = PRINTER with type t = ext with_list_element

module Make
    (P : GEN with type t = ext query_expression)
    (C : GEN with type t = ext column_list)
    (I : GEN with type t = ext identifier) : S = struct
  type t = ext with_list_element

  let print f t ~option =
    match t with
    | `With_list_element (ident, column_list, q, _) ->
      let module P = (val P.generate ()) in
      let module C = (val C.generate ()) in
      let module I = (val I.generate ()) in
      I.print f ident ~option;
      Fmt.string f " ";
      Option.iter
        (fun v ->
          C.print f v ~option;
          Fmt.string f " ")
        column_list;
      Printer_token.print f Kw_as ~option;
      Fmt.string f " ";
      Printer_token.print f Tok_lparen ~option;
      P.print f q ~option;
      Printer_token.print f Tok_rparen ~option
end
