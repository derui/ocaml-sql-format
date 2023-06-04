open Parser.Ast
include Printer_intf

include (
  struct
    type t = statement

    let print f statement ~option =
      match statement with
      | Stmt_select { select_list; _ } ->
        Token_printer.print f Parser.Token.Kw_select ~option;
        Fmt.string f " ";
        Select_list_printer.print f select_list ~option
  end :
    S with type t = statement)
