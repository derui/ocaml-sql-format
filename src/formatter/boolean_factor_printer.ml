open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = boolean_factor

    let print f t ~option =
      match t with
      | `Not primary ->
        Token_printer.print f Kw_not ~option;
        Boolean_primary_printer.print f primary ~option
      | `Normal primary -> Boolean_primary_printer.print f primary ~option
  end :
    S with type t = boolean_factor)
