open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext numeric_value_expression

module Make (Term : GEN with type t = ext term) : S = struct
  type t = ext numeric_value_expression

  let print f t ~option =
    match t with
    | `Numeric_value_expression (term, terms, _) ->
      let module Term = (val Term.generate ()) in
      Term.print f term ~option;

      List.iter
        (fun (op, term) ->
          (match op with
          | `plus -> Printer_token.print f Op_plus ~option
          | `minus -> Printer_token.print f Op_minus ~option);
          Term.print f term ~option)
        terms
end
