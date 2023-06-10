open Parser.Ast
include Printer_intf

include (
  struct
    type t = entry

    let print f entry ~option =
      match entry with
      | Directly_executable_statement v ->
        Directly_executable_statement_printer.print f v ~option
  end :
    S with type t = entry)
