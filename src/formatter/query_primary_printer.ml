open Parser.Ast
include Printer_intf

include (
  struct
    type t = query_primary

    let print f t ~option =
      match t with
      | Query query -> Query_printer.print f query ~option
  end :
    S with type t = query_primary)
