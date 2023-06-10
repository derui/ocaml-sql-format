open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = non_numeric_literal

    let print f t ~option =
      match t with
      | `string v -> Fmt.string f v
      | `typed_string v -> Fmt.string f v
      | `bin_string v -> Fmt.string f v
      | `TRUE -> Token_printer.print f Kw_true ~option
      | `FALSE -> Token_printer.print f Kw_false ~option
      | `UNKNOWN -> Token_printer.print f Kw_unknown ~option
      | `NULL -> Token_printer.print f Kw_null ~option
      | `datetime_string v -> (
        match v with
        | `date v ->
          Token_printer.print f Kw_date ~option;
          Fmt.string f v
        | `time v ->
          Token_printer.print f Kw_time ~option;
          Fmt.string f v
        | `timestamp v ->
          Token_printer.print f Kw_timestamp ~option;
          Fmt.string f v)
  end :
    S with type t = non_numeric_literal)
