open Parser.Ast
include Printer_intf

include (
  struct
    type t = query_expression_body

    let print f t ~option =
      match t with
      | Query_expression_body { term; order_by; _ } ->
        Query_term_printer.print f term ~option;

        Option.iter
          (fun v ->
            Fmt.string f " ";
            Order_by_clause_printer.print f v ~option)
          order_by
  end :
    S with type t = query_expression_body)
