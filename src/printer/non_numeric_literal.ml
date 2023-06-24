open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext non_numeric_literal

module Make () : S = struct
  type t = ext non_numeric_literal

  let print f t ~option =
    match t with
    | Non_numeric_literal (`string v, _) -> Fmt.string f v
    | Non_numeric_literal (`typed_string v, _) -> Fmt.string f v
    | Non_numeric_literal (`bin_string v, _) -> Fmt.string f v
    | Non_numeric_literal (`TRUE, _) -> Printer_token.print f Kw_true ~option
    | Non_numeric_literal (`FALSE, _) -> Printer_token.print f Kw_false ~option
    | Non_numeric_literal (`UNKNOWN, _) ->
      Printer_token.print f Kw_unknown ~option
    | Non_numeric_literal (`NULL, _) -> Printer_token.print f Kw_null ~option
    | Non_numeric_literal (`datetime_string v, _) -> (
      match v with
      | `date v ->
        Printer_token.print f Kw_date ~option;
        Fmt.string f v
      | `time v ->
        Printer_token.print f Kw_time ~option;
        Fmt.string f v
      | `timestamp v ->
        Printer_token.print f Kw_timestamp ~option;
        Fmt.string f v)
end
