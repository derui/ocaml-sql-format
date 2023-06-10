open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = boolean_value_expression

    let print f t ~option =
      let term, terms = t in
      Boolean_term_printer.print f term ~option;

      List.iter
        (fun v ->
          Token_printer.print f Kw_or ~option;
          Boolean_term_printer.print f v ~option)
        terms
  end :
    S with type t = boolean_value_expression)
