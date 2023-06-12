open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = order_by_clause

    let print f t ~option =
      match t with
      | Order_by_clause [] -> failwith "Invalid syntax"
      | Order_by_clause (first :: rest) ->
        Token_printer.print f Kw_order ~option;
        Fmt.string f " ";
        Token_printer.print f Kw_by ~option;
        Fmt.string f " ";
        Sort_specification_printer.print f first ~option;

        List.iter
          (fun v ->
            Token_printer.print f Tok_comma ~option;
            Sort_specification_printer.print f v ~option)
          rest
  end :
    S with type t = order_by_clause)
