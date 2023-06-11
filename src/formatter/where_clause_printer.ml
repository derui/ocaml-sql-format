open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = where_clause

    let print f (Where_clause t) ~option =
      Token_printer.print f ~option Kw_where;
      Fmt.string f " ";
      Boolean_value_expression_printer.print f ~option t
  end :
    S with type t = where_clause)
