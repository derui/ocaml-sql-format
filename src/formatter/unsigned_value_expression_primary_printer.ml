open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = unsigned_value_expression_primary

    let print f t ~option =
      match t with
      | `parameter_qmark -> Token_printer.print f Tok_qmark ~option
      | `parameter_dollar (Literal.Unsigned_integer v) -> Fmt.string f v
      | `identifier (Ident v) -> Fmt.string f v
  end :
    S with type t = unsigned_value_expression_primary)
