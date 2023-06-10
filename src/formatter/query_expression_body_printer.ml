open Parser.Ast
include Printer_intf

include (
  struct
    type t = query_expression_body

    let print f t ~option =
      match t with
      | Query_term term -> Query_term_printer.print f term ~option
  end :
    S with type t = query_expression_body)
