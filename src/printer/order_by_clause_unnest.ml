open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext order_by_clause

module Make (SS : GEN with type t = ext sort_specification) : S = struct
  type t = ext order_by_clause

  let print f t ~option =
    match t with
    | Order_by_clause ([], _) -> failwith "Invalid syntax"
    | Order_by_clause (first :: rest, _) ->
      Printer_token.print f Kw_order ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_by ~option;
      Fmt.string f " ";

      let module SS = (val SS.generate ()) in
      SS.print f first ~option;

      List.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Fmt.string f " ";
          SS.print f v ~option)
        rest
end
