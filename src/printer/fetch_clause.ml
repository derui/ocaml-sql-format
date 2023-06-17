open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext fetch_clause

module Make (IP : GEN with type t = ext integer_parameter) : S = struct
  type t = ext fetch_clause

  let print f t ~option =
    match t with
    | `Fetch_clause ({ position; param }, rows, _) ->
      Printer_token.print f Kw_fetch ~option;
      Fmt.string f " ";
      let kw =
        match position with
        | `first -> Kw_first
        | `next -> Kw_next
      in
      Printer_token.print f kw ~option;
      Option.iter
        (fun v ->
          let module IP = (val IP.generate ()) in
          Fmt.string f " ";
          IP.print f v ~option)
        param;
      Fmt.string f " ";
      let kw =
        match rows with
        | `row -> Kw_row
        | `rows -> Kw_rows
      in
      Printer_token.print f kw ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_only ~option
end
