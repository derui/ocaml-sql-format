open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = limit_clause

    let print f t ~option =
      match t with
      | Limit_clause_limit { count; offset } ->
        Token_printer.print f Kw_limit ~option;
        Fmt.string f " ";
        Integer_parameter_printer.print f count ~option;
        Option.iter
          (function
            | `comma param ->
              Fmt.string f " ";
              Token_printer.print f Tok_comma ~option;
              Fmt.string f " ";
              Integer_parameter_printer.print f param ~option
            | `keyword param ->
              Fmt.string f " ";
              Token_printer.print f Kw_offset ~option;
              Fmt.string f " ";
              Integer_parameter_printer.print f param ~option)
          offset
      | Limit_clause_offset { start; rows; fetch } ->
        Token_printer.print f Kw_offset ~option;
        Fmt.string f " ";
        Integer_parameter_printer.print f start ~option;
        Fmt.string f " ";
        let kw =
          match rows with
          | `row -> Kw_row
          | `rows -> Kw_rows
        in
        Token_printer.print f kw ~option;

        Option.iter
          (fun fetch ->
            Fmt.string f " ";
            Fetch_clause_printer.print f fetch ~option)
          fetch
      | Limit_clause_fetch v -> Fetch_clause_printer.print f v ~option
  end :
    S with type t = limit_clause)
