open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_value_expression

module Make (B : GEN with type t = ext boolean_term) : S = struct
  type t = ext boolean_value_expression

  let print f t ~option =
    match t with
    | Boolean_value_expression (term, terms, _) ->
      let module B = (val B.generate ()) in
      B.print f term ~option;

      List.iter
        (fun v ->
          Fmt.cut f ();
          Printer_token.print f Kw_or ~option;
          Fmt.string f "  ";
          B.print f v ~option)
        terms
end
