open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = fetch_clause

    let print f t ~option =
      match t with
      | Fetch_clause { position; param; rows } ->
        Token_printer.print f Kw_fetch ~option;
        Fmt.string f " ";
        let kw =
          match position with
          | `first -> Kw_first
          | `next -> Kw_next
        in
        Token_printer.print f kw ~option;
        Option.iter
          (fun v ->
            Fmt.string f " ";
            Integer_parameter_printer.print f v ~option)
          param;
        Fmt.string f " ";
        let kw =
          match rows with
          | `row -> Kw_row
          | `rows -> Kw_rows
        in
        Token_printer.print f kw ~option;
        Fmt.string f " ";
        Token_printer.print f Kw_only ~option
  end :
    S with type t = fetch_clause)
