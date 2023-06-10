open Parser.Ast
include Printer_intf

include (
  struct
    type t = unsigned_numeric_literal

    let print f t ~option:_ =
      match t with
      | `unsigned (Literal.Unsigned_integer v) -> Fmt.string f v
      | `approximate (Literal.Approximate_numeric v) -> Fmt.string f v
      | `decimal (Literal.Decimal_numeric v) -> Fmt.string f v
  end :
    S with type t = unsigned_numeric_literal)
