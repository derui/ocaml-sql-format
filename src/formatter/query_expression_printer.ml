open Parser.Ast
include Printer_intf

include (
  struct
    type t = query_expression

    let print f t ~option = Query_expression_body_printer.print f t.body ~option
  end :
    S with type t = query_expression)
