open Parser.Ast
include Printer_intf

include (
  struct
    type t = query_term

    let print f t ~option =
      let primary, _ = t in
      Query_primary_printer.print f primary ~option
  end :
    S with type t = query_term)
