open Parser.Ast
include Printer_intf

include (
  struct
    type t = directly_executable_statement

    let print f t ~option =
      match t with
      | Query_expression v -> Query_expression_printer.print f v ~option
  end :
    S with type t = directly_executable_statement)
