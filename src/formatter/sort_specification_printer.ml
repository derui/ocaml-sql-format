open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = sort_specification

    let print f (Sort_specification { key; order; null_order }) ~option =
      Boolean_value_expression_printer.print f key ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Token_printer.print f
            (match v with
            | `asc -> Kw_asc
            | `desc -> Kw_desc)
            ~option)
        order;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Token_printer.print f Kw_null ~option;
          Fmt.string f " ";
          Token_printer.print f
            (match v with
            | `null_first -> Kw_first
            | `null_last -> Kw_last)
            ~option)
        null_order
  end :
    S with type t = sort_specification)
