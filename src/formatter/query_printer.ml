open Parser.Ast
include Printer_intf

include (
  struct
    type t = query

    let print f t ~option =
      let { clause; _ } = t in
      Select_clause_printer.print f clause ~option
  end :
    S with type t = query)
