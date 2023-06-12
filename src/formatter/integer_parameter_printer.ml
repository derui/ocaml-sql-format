open Parser.Ast
include Printer_intf

include (
  struct
    type t = integer_parameter

    let print f t ~option =
      match t with
      | `unsigned_integer (Literal.Unsigned_integer v) -> Fmt.string f v
      | `expression v ->
        Unsigned_value_expression_primary_printer.print f v ~option
  end :
    S with type t = integer_parameter)
