open Parser.Ast
include Printer_intf

include (
  struct
    type t = statement

    let to_string statement ~option =
      match statement with
      | Stmt_select { select_list; _ } ->
        "SELECT" ^ " " ^ Select_list_printer.to_string select_list ~option
  end :
    S with type t = statement)
