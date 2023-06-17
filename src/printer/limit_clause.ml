open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext limit_clause

module Make
    (IP : GEN with type t = ext integer_parameter)
    (Fc : GEN with type t = ext fetch_clause) : S = struct
  type t = ext limit_clause

  let print f t ~option =
    match t with
    | `Limit_clause (`limit { count; offset }, _) ->
      let module IP = (val IP.generate ()) in
      Printer_token.print f Kw_limit ~option;
      Fmt.string f " ";
      IP.print f count ~option;
      Option.iter
        (function
          | `comma param ->
            Fmt.string f " ";
            Printer_token.print f Tok_comma ~option;
            Fmt.string f " ";
            IP.print f param ~option
          | `keyword param ->
            Fmt.string f " ";
            Printer_token.print f Kw_offset ~option;
            Fmt.string f " ";
            IP.print f param ~option)
        offset
    | `Limit_clause (`offset ({ start; fetch }, rows), _) ->
      let module IP = (val IP.generate ()) in
      Printer_token.print f Kw_offset ~option;
      Fmt.string f " ";
      IP.print f start ~option;
      Fmt.string f " ";
      let kw =
        match rows with
        | `row -> Kw_row
        | `rows -> Kw_rows
      in
      Printer_token.print f kw ~option;

      Option.iter
        (fun fetch ->
          let module Fc = (val Fc.generate ()) in
          Fmt.string f " ";
          Fc.print f fetch ~option)
        fetch
    | `Limit_clause (`fetch v, _) ->
      let module Fc = (val Fc.generate ()) in
      Fc.print f v ~option
end
