open Parser.Ast
include Printer_intf

include (
  struct
    type t = boolean_primary

    let print f t ~option =
      match t with
      | Boolean_primary { value } ->
        Value_printers.Common_value_expression_printer.print f value ~option
  end :
    S with type t = boolean_primary)
