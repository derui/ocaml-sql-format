open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = having_clause

    let print f (Having_clause t) ~option =
      Token_printer.print f ~option Kw_having;
      Fmt.string f " ";
      Boolean_value_expression_printer.print f ~option t
  end :
    S with type t = having_clause)
