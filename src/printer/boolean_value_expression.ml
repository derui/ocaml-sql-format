open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_value_expression

module Make (B : GEN with type t = ext boolean_term) : S = struct
  type t = ext boolean_value_expression

  let print_indent f = function
    | Boolean_value_expression (term, [], _) -> (
      match term with
      | Boolean_term (_, [], _) -> ()
      | Boolean_term (_, _, _) -> Sfmt.indent 4 f ())
    | Boolean_value_expression (_, _, _) -> Sfmt.indent 4 f ()

  let print f t ~option =
    match t with
    | Boolean_value_expression (term, terms, _) ->
      print_indent f t;
      let module B = (val B.generate ()) in
      B.print f term ~option;

      List.iter
        (fun v ->
          Fmt.cut f ();
          Fmt.string f " ";
          Printer_token.print f Kw_or ~option;
          Fmt.string f " ";
          B.print f v ~option)
        terms
end
